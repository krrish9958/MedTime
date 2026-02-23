import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../providers/appointment_provider.dart';

class AppointmentScreen extends ConsumerWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visits = ref.watch(appointmentProvider);
    final notifier = ref.read(appointmentProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Visits'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton.icon(
              onPressed: () => _openAddVisitDialog(context, notifier),
              icon: const Icon(Icons.add_alert_outlined),
              label: const Text('Add'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 110),
        children: [
          if (visits.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('No doctor visits added yet.'),
              ),
            )
          else
            ...visits.reversed.map(
              (visit) => Card(
                child: ListTile(
                  title: Text(visit.doctorName),
                  subtitle: Text(
                    '${visit.reason} | ${formatDateTime(visit.visitAt)}',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _openAddVisitDialog(
    BuildContext context,
    AppointmentNotifier notifier,
  ) async {
    final doctorCtrl = TextEditingController();
    final reasonCtrl = TextEditingController();
    DateTime visitAt = DateTime.now().add(const Duration(days: 1));

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Doctor Visit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: doctorCtrl,
                decoration: const InputDecoration(labelText: 'Doctor Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: reasonCtrl,
                decoration: const InputDecoration(labelText: 'Reason'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Visit date:'),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 3650),
                        ),
                        initialDate: visitAt,
                      );
                      if (picked != null) {
                        visitAt = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                          visitAt.hour,
                          visitAt.minute,
                        );
                      }
                    },
                    child: Text(formatDate(visitAt)),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (doctorCtrl.text.trim().isEmpty ||
                    reasonCtrl.text.trim().isEmpty) {
                  return;
                }
                notifier.addVisit(
                  doctorName: doctorCtrl.text.trim(),
                  reason: reasonCtrl.text.trim(),
                  visitAt: visitAt,
                );
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
