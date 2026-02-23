import '../entities/medicine.dart';
import '../entities/medicine_intake.dart';

abstract class MedicineRepository {
  Future<List<Medicine>> getMedicines();
  Future<List<MedicineIntake>> getTodaySchedule();
  Future<void> addMedicine(Medicine medicine);
  Future<void> markTaken(String medicineId, DateTime scheduledAt);
  Future<void> markSkipped(String medicineId, DateTime scheduledAt);
}
