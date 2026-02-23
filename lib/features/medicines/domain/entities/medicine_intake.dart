class MedicineIntake {
  const MedicineIntake({
    required this.medicineId,
    required this.scheduledAt,
    this.takenAt,
    this.skipped = false,
  });

  final String medicineId;
  final DateTime scheduledAt;
  final DateTime? takenAt;
  final bool skipped;

  bool get isCompleted => takenAt != null || skipped;

  MedicineIntake copyWith({DateTime? takenAt, bool? skipped}) {
    return MedicineIntake(
      medicineId: medicineId,
      scheduledAt: scheduledAt,
      takenAt: takenAt ?? this.takenAt,
      skipped: skipped ?? this.skipped,
    );
  }
}
