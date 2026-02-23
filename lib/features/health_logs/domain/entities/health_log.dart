enum HealthMetricType { bloodPressure, bloodSugar, pulse }

class HealthLog {
  const HealthLog({
    required this.id,
    required this.type,
    required this.value,
    required this.recordedAt,
    this.note,
  });

  final String id;
  final HealthMetricType type;
  final String value;
  final DateTime recordedAt;
  final String? note;
}
