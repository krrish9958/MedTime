import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/app_database.dart';
import '../../../../core/services/notification_service.dart';
import '../../data/repositories/isar_medicine_repository.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/medicine_intake.dart';
import '../../domain/repositories/medicine_repository.dart';

final medicineRepositoryProvider = Provider<MedicineRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final notifications = ref.watch(notificationServiceProvider);
  return IsarMedicineRepository(db, notifications);
});

class MedicinesState {
  const MedicinesState({
    required this.medicines,
    required this.today,
    this.loading = false,
  });

  final List<Medicine> medicines;
  final List<MedicineIntake> today;
  final bool loading;

  MedicinesState copyWith({
    List<Medicine>? medicines,
    List<MedicineIntake>? today,
    bool? loading,
  }) {
    return MedicinesState(
      medicines: medicines ?? this.medicines,
      today: today ?? this.today,
      loading: loading ?? this.loading,
    );
  }

  factory MedicinesState.initial() =>
      const MedicinesState(medicines: [], today: [], loading: false);
}

class MedicinesNotifier extends StateNotifier<MedicinesState> {
  MedicinesNotifier(this._repo) : super(MedicinesState.initial()) {
    Future.microtask(refresh);
  }

  final MedicineRepository _repo;

  Future<void> refresh() async {
    state = state.copyWith(loading: true);

    var medicines = await _repo.getMedicines();
    if (medicines.isEmpty) {
      await _seedDemoMedicines();
      medicines = await _repo.getMedicines();
    }

    final today = await _repo.getTodaySchedule();
    state = state.copyWith(medicines: medicines, today: today, loading: false);
  }

  Future<void> addMedicine({
    required String name,
    required String dosage,
    required MedicineFrequency frequency,
    String? instructions,
  }) async {
    final medicine = Medicine(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      dosage: dosage,
      startDate: DateTime.now(),
      frequency: frequency,
      instructions: instructions,
    );
    await _repo.addMedicine(medicine);
    await refresh();
  }

  Future<void> markTaken(MedicineIntake intake) async {
    await _repo.markTaken(intake.medicineId, intake.scheduledAt);
    await refresh();
  }

  Future<void> markSkipped(MedicineIntake intake) async {
    await _repo.markSkipped(intake.medicineId, intake.scheduledAt);
    await refresh();
  }

  Future<void> _seedDemoMedicines() async {
    final now = DateTime.now();
    final samples = [
      Medicine(
        id: 'demo_omega3',
        name: 'Omega 3',
        dosage: '1 pill',
        startDate: now,
        frequency: MedicineFrequency.daily,
        instructions: 'take before eat',
      ),
      Medicine(
        id: 'demo_vitamin_a',
        name: 'Vitamin A',
        dosage: '1 capsule',
        startDate: now,
        frequency: MedicineFrequency.twiceDaily,
        instructions: 'take after lunch',
      ),
    ];

    for (final medicine in samples) {
      await _repo.addMedicine(medicine);
    }
  }
}

final medicinesProvider =
    StateNotifierProvider<MedicinesNotifier, MedicinesState>((ref) {
      final repo = ref.watch(medicineRepositoryProvider);
      return MedicinesNotifier(repo);
    });
