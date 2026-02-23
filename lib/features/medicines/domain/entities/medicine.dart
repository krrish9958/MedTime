enum MedicineFrequency { daily, twiceDaily }

class Medicine {
  const Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.startDate,
    required this.frequency,
    this.instructions,
  });

  final String id;
  final String name;
  final String dosage;
  final DateTime startDate;
  final MedicineFrequency frequency;
  final String? instructions;

  List<DateTime> scheduleForDate(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final customTimes = _extractTimesFromInstructions(day);
    if (customTimes.isNotEmpty) {
      if (frequency == MedicineFrequency.daily) {
        return [customTimes.first];
      }
      return customTimes.take(2).toList();
    }

    switch (frequency) {
      case MedicineFrequency.daily:
        return [DateTime(day.year, day.month, day.day, 8, 0)];
      case MedicineFrequency.twiceDaily:
        return [
          DateTime(day.year, day.month, day.day, 8, 0),
          DateTime(day.year, day.month, day.day, 20, 0),
        ];
    }
  }

  List<DateTime> _extractTimesFromInstructions(DateTime day) {
    final text = instructions;
    if (text == null || text.isEmpty) return const [];

    final regex = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)', caseSensitive: false);
    final matches = regex.allMatches(text);
    final results = <DateTime>[];

    for (final match in matches) {
      final hourRaw = int.tryParse(match.group(1) ?? '');
      final minuteRaw = int.tryParse(match.group(2) ?? '');
      final periodRaw = (match.group(3) ?? '').toUpperCase();
      if (hourRaw == null || minuteRaw == null) continue;

      var hour = hourRaw % 12;
      if (periodRaw == 'PM') hour += 12;
      results.add(DateTime(day.year, day.month, day.day, hour, minuteRaw));
    }

    results.sort((a, b) => a.compareTo(b));
    return results;
  }
}
