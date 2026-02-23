class Appointment {
  const Appointment({
    required this.id,
    required this.doctorName,
    required this.visitAt,
    required this.reason,
  });

  final String id;
  final String doctorName;
  final DateTime visitAt;
  final String reason;
}
