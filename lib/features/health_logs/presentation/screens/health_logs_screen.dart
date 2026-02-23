import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/health_log.dart';
import '../providers/health_logs_provider.dart';

class HealthLogsScreen extends ConsumerWidget {
  const HealthLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(healthLogsProvider);
    final notifier = ref.read(healthLogsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Logs'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton.icon(
              onPressed: () => _openAddLogSheet(context, notifier),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 110),
        children: [
          if (logs.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('No logs yet. Add BP, sugar, or pulse entries.'),
              ),
            )
          else
            ...logs.reversed.map(
              (log) => Card(
                child: ListTile(
                  title: Text(_label(log.type)),
                  subtitle: Text(
                    '${log.value} | ${formatDateTime(log.recordedAt)}',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  static String _label(HealthMetricType type) {
    switch (type) {
      case HealthMetricType.bloodPressure:
        return 'Blood Pressure';
      case HealthMetricType.bloodSugar:
        return 'Blood Sugar';
      case HealthMetricType.pulse:
        return 'Pulse';
    }
  }

  void _openAddLogSheet(BuildContext context, HealthLogsNotifier notifier) {
    final valueCtrl = TextEditingController();
    HealthMetricType selectedType = HealthMetricType.bloodPressure;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<HealthMetricType>(
                    initialValue: selectedType,
                    items: const [
                      DropdownMenuItem(
                        value: HealthMetricType.bloodPressure,
                        child: Text('Blood Pressure'),
                      ),
                      DropdownMenuItem(
                        value: HealthMetricType.bloodSugar,
                        child: Text('Blood Sugar'),
                      ),
                      DropdownMenuItem(
                        value: HealthMetricType.pulse,
                        child: Text('Pulse'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => selectedType = value);
                    },
                    decoration: const InputDecoration(labelText: 'Type'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: valueCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Value',
                      hintText: 'e.g. 120/80, 145 mg/dL, 76 bpm',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (valueCtrl.text.trim().isEmpty) return;
                        notifier.addLog(
                          type: selectedType,
                          value: valueCtrl.text.trim(),
                        );
                        Navigator.pop(ctx);
                      },
                      child: const Text('Save Log'),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
