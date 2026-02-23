import 'package:isar/isar.dart';

import '../../../../core/services/app_database.dart';
import '../../../../core/services/notification_service.dart';
import '../../domain/entities/medicine.dart';
import '../../domain/entities/medicine_intake.dart';
import '../../domain/repositories/medicine_repository.dart';
import '../models/medicine_intake_record.dart';
import '../models/medicine_record.dart';

class IsarMedicineRepository implements MedicineRepository {
  IsarMedicineRepository(this._db, this._notifications);

  final AppDatabase _db;
  final NotificationService _notifications;

  @override
  Future<void> addMedicine(Medicine medicine) async {
    await _db.isar.writeTxn(() async {
      await _db.isar.medicineRecords.put(MedicineRecord.fromEntity(medicine));
    });

    await _ensureIntakesForMedicineOn(DateTime.now(), medicine);
  }

  @override
  Future<List<Medicine>> getMedicines() async {
    final records = await _db.isar.medicineRecords
        .where()
        .sortByName()
        .findAll();
    return records.map((record) => record.toEntity()).toList();
  }

  @override
  Future<List<MedicineIntake>> getTodaySchedule() async {
    await _ensureTodayIntakes();
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final intakeRecords = await _db.isar.medicineIntakeRecords
        .filter()
        .scheduledAtBetween(start, end)
        .findAll();
    intakeRecords.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return intakeRecords.map((record) => record.toEntity()).toList();
  }

  @override
  Future<void> markSkipped(String medicineId, DateTime scheduledAt) async {
    final key = MedicineIntakeRecord.buildKey(medicineId, scheduledAt);
    final record = await _db.isar.medicineIntakeRecords
        .filter()
        .keyEqualTo(key)
        .findFirst();
    if (record == null) return;

    record.skipped = true;
    record.takenAt = null;
    await _db.isar.writeTxn(() async {
      await _db.isar.medicineIntakeRecords.put(record);
    });

    await _notifications.cancelReminder(
      _notificationId(medicineId, scheduledAt),
    );
  }

  @override
  Future<void> markTaken(String medicineId, DateTime scheduledAt) async {
    final key = MedicineIntakeRecord.buildKey(medicineId, scheduledAt);
    final record = await _db.isar.medicineIntakeRecords
        .filter()
        .keyEqualTo(key)
        .findFirst();
    if (record == null) return;

    record.skipped = false;
    record.takenAt = DateTime.now();
    await _db.isar.writeTxn(() async {
      await _db.isar.medicineIntakeRecords.put(record);
    });

    await _notifications.cancelReminder(
      _notificationId(medicineId, scheduledAt),
    );
  }

  Future<void> _ensureTodayIntakes() async {
    final medicines = await getMedicines();
    for (final medicine in medicines) {
      await _ensureIntakesForMedicineOn(DateTime.now(), medicine);
    }
  }

  Future<void> _ensureIntakesForMedicineOn(
    DateTime day,
    Medicine medicine,
  ) async {
    final dayStart = DateTime(day.year, day.month, day.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final slots = medicine.scheduleForDate(dayStart);
    final expectedKeys = slots
        .map((slot) => MedicineIntakeRecord.buildKey(medicine.id, slot))
        .toSet();

    final existingForDay = await _db.isar.medicineIntakeRecords
        .filter()
        .medicineIdEqualTo(medicine.id)
        .scheduledAtBetween(dayStart, dayEnd)
        .findAll();

    final staleRecords = existingForDay
        .where((record) => !expectedKeys.contains(record.key))
        .toList();
    if (staleRecords.isNotEmpty) {
      await _db.isar.writeTxn(() async {
        await _db.isar.medicineIntakeRecords.deleteAll(
          staleRecords.map((e) => e.isarId).toList(),
        );
      });
      for (final stale in staleRecords) {
        await _notifications.cancelReminder(
          _notificationId(stale.medicineId, stale.scheduledAt),
        );
      }
    }

    final toInsert = <MedicineIntakeRecord>[];

    for (final slot in slots) {
      final key = MedicineIntakeRecord.buildKey(medicine.id, slot);
      final exists = existingForDay.any((record) => record.key == key);
      if (exists) continue;

      toInsert.add(
        MedicineIntakeRecord.create(medicineId: medicine.id, scheduledAt: slot),
      );

      await _notifications.scheduleMedicineReminder(
        id: _notificationId(medicine.id, slot),
        medicineName: medicine.name,
        scheduledAt: slot,
      );
    }

    if (toInsert.isEmpty) return;
    await _db.isar.writeTxn(() async {
      await _db.isar.medicineIntakeRecords.putAll(toInsert);
    });
  }

  int _notificationId(String medicineId, DateTime scheduledAt) {
    return (medicineId.hashCode ^ scheduledAt.millisecondsSinceEpoch) &
        0x7fffffff;
  }
}
