import 'package:isar/isar.dart';

import '../../domain/entities/medicine.dart';

part 'medicine_record.g.dart';

@collection
class MedicineRecord {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String id;

  late String name;
  late String dosage;
  late DateTime startDate;
  late int frequency;
  String? instructions;

  Medicine toEntity() {
    return Medicine(
      id: id,
      name: name,
      dosage: dosage,
      startDate: startDate,
      frequency: MedicineFrequency.values[frequency],
      instructions: instructions,
    );
  }

  static MedicineRecord fromEntity(Medicine medicine) {
    return MedicineRecord()
      ..id = medicine.id
      ..name = medicine.name
      ..dosage = medicine.dosage
      ..startDate = medicine.startDate
      ..frequency = medicine.frequency.index
      ..instructions = medicine.instructions;
  }
}
