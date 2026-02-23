import 'package:isar/isar.dart';

import '../../domain/entities/medicine_intake.dart';

part 'medicine_intake_record.g.dart';

@collection
class MedicineIntakeRecord {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String key;

  late String medicineId;
  late DateTime scheduledAt;
  DateTime? takenAt;
  bool skipped = false;

  MedicineIntake toEntity() {
    return MedicineIntake(
      medicineId: medicineId,
      scheduledAt: scheduledAt,
      takenAt: takenAt,
      skipped: skipped,
    );
  }

  static MedicineIntakeRecord create({
    required String medicineId,
    required DateTime scheduledAt,
    DateTime? takenAt,
    bool skipped = false,
  }) {
    return MedicineIntakeRecord()
      ..key = buildKey(medicineId, scheduledAt)
      ..medicineId = medicineId
      ..scheduledAt = scheduledAt
      ..takenAt = takenAt
      ..skipped = skipped;
  }

  static String buildKey(String medicineId, DateTime scheduledAt) {
    return '$medicineId-${scheduledAt.millisecondsSinceEpoch}';
  }
}
