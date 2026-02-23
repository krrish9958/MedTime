import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/appointment.dart';

class AppointmentNotifier extends StateNotifier<List<Appointment>> {
  AppointmentNotifier(this._storage) : super(const []) {
    Future.microtask(_load);
  }

  final LocalStorageService _storage;
  static const _fileName = 'appointments.json';

  void addVisit({
    required String doctorName,
    required DateTime visitAt,
    required String reason,
  }) {
    final updated = [
      ...state,
      Appointment(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        doctorName: doctorName,
        visitAt: visitAt,
        reason: reason,
      ),
    ];
    state = updated;
    _persist(updated);
  }

  Future<void> _load() async {
    final rows = await _storage.readJsonList(_fileName);
    state = rows
        .map((row) {
          final id = row['id'] as String?;
          final doctorName = row['doctorName'] as String?;
          final reason = row['reason'] as String?;
          final visitAtRaw = row['visitAt'] as String?;
          final visitAt = visitAtRaw == null ? null : DateTime.tryParse(visitAtRaw);

          if (id == null || doctorName == null || reason == null || visitAt == null) {
            return null;
          }

          return Appointment(
            id: id,
            doctorName: doctorName,
            visitAt: visitAt,
            reason: reason,
          );
        })
        .whereType<Appointment>()
        .toList();
  }

  Future<void> _persist(List<Appointment> visits) async {
    await _storage.writeJsonList(
      _fileName,
      visits
          .map(
            (visit) => {
              'id': visit.id,
              'doctorName': visit.doctorName,
              'visitAt': visit.visitAt.toIso8601String(),
              'reason': visit.reason,
            },
          )
          .toList(),
    );
  }
}

final appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, List<Appointment>>((ref) {
      final storage = ref.watch(localStorageProvider);
      return AppointmentNotifier(storage);
    });
