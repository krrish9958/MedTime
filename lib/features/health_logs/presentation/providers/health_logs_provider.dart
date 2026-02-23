import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/health_log.dart';

class HealthLogsNotifier extends StateNotifier<List<HealthLog>> {
  HealthLogsNotifier(this._storage) : super(const []) {
    Future.microtask(_load);
  }

  final LocalStorageService _storage;
  static const _fileName = 'health_logs.json';

  void addLog({
    required HealthMetricType type,
    required String value,
    String? note,
  }) {
    final updated = [
      ...state,
      HealthLog(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        type: type,
        value: value,
        recordedAt: DateTime.now(),
        note: note,
      ),
    ];
    state = updated;
    _persist(updated);
  }

  Future<void> _load() async {
    final rows = await _storage.readJsonList(_fileName);
    state = rows
        .map((row) {
          final typeIndex = row['type'] as int?;
          if (typeIndex == null ||
              typeIndex < 0 ||
              typeIndex >= HealthMetricType.values.length) {
            return null;
          }

          final recordedAtRaw = row['recordedAt'] as String?;
          final recordedAt = recordedAtRaw == null
              ? null
              : DateTime.tryParse(recordedAtRaw);
          if (recordedAt == null) return null;

          final id = row['id'] as String?;
          final value = row['value'] as String?;
          if (id == null || value == null) return null;

          return HealthLog(
            id: id,
            type: HealthMetricType.values[typeIndex],
            value: value,
            recordedAt: recordedAt,
            note: row['note'] as String?,
          );
        })
        .whereType<HealthLog>()
        .toList();
  }

  Future<void> _persist(List<HealthLog> logs) async {
    await _storage.writeJsonList(
      _fileName,
      logs
          .map(
            (log) => {
              'id': log.id,
              'type': log.type.index,
              'value': log.value,
              'recordedAt': log.recordedAt.toIso8601String(),
              'note': log.note,
            },
          )
          .toList(),
    );
  }
}

final healthLogsProvider =
    StateNotifierProvider<HealthLogsNotifier, List<HealthLog>>((ref) {
      final storage = ref.watch(localStorageProvider);
      return HealthLogsNotifier(storage);
    });
