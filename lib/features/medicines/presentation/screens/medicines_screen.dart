import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/medicine.dart';
import '../providers/medicines_provider.dart';
import 'add_medicine_screen.dart';

class MedicinesScreen extends ConsumerWidget {
  const MedicinesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(medicinesProvider);
    final notifier = ref.read(medicinesProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: state.loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 120),
                children: [
                  _Header(
                    today: DateTime.now(),
                    onAdd: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMedicineScreen(
                            onSave: (name, dosage, frequency, instructions) {
                              return notifier.addMedicine(
                                name: name,
                                dosage: dosage,
                                frequency: frequency,
                                instructions: instructions,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _SectionTitle(text: 'Your Next Pill'),
                  const SizedBox(height: 8),
                  _nextPillCard(state),
                  const SizedBox(height: 16),
                  _SectionTitle(text: 'Today\'s Schedule'),
                  const SizedBox(height: 8),
                  ..._scheduleCards(state, notifier),
                  const SizedBox(height: 16),
                  _SectionTitle(text: 'Your Cabinet'),
                  const SizedBox(height: 8),
                  ..._cabinetCards(state),
                ],
              ),
      ),
    );
  }

  Widget _nextPillCard(MedicinesState state) {
    final next = state.today.where((e) => !e.isCompleted).toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    if (next.isEmpty) {
      return _CardBox(
        child: const ListTile(
          leading: Icon(Icons.medication_outlined),
          title: Text('No pending medicine'),
          subtitle: Text('You are done for now'),
        ),
      );
    }

    final intake = next.first;
    final medicine = _resolveMedicine(state, intake.medicineId);

    return _CardBox(
      child: ListTile(
        leading: const Icon(Icons.medication_rounded, color: Color(0xFF7A3CF3)),
        title: Text(
          medicine.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${medicine.dosage} ${medicine.instructions ?? ''}'.trim(),
        ),
        trailing: Text(formatTime(intake.scheduledAt)),
      ),
    );
  }

  List<Widget> _scheduleCards(
    MedicinesState state,
    MedicinesNotifier notifier,
  ) {
    final sorted = [...state.today]
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    if (sorted.isEmpty) {
      return [
        const _CardBox(
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Text('No medicines scheduled for today.'),
          ),
        ),
      ];
    }

    return sorted.map((intake) {
      final medicine = _resolveMedicine(state, intake.medicineId);
      final subtitle = intake.takenAt != null
          ? 'Taken at ${formatTime(intake.takenAt!)}'
          : intake.skipped
          ? 'Skipped'
          : 'Pending';

      return _CardBox(
        child: ListTile(
          leading: Text(
            formatTime(intake.scheduledAt),
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
          title: Text(
            medicine.name,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(subtitle),
          trailing: intake.isCompleted
              ? const Icon(Icons.check_circle_rounded, color: Colors.green)
              : Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      onPressed: () async => notifier.markSkipped(intake),
                      icon: const Icon(Icons.close_rounded),
                    ),
                    IconButton(
                      onPressed: () async => notifier.markTaken(intake),
                      icon: const Icon(Icons.check_rounded),
                    ),
                  ],
                ),
        ),
      );
    }).toList();
  }

  List<Widget> _cabinetCards(MedicinesState state) {
    if (state.medicines.isEmpty) {
      return [
        const _CardBox(
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Text('Add your first medicine with the + Add button.'),
          ),
        ),
      ];
    }

    return state.medicines
        .take(4)
        .map(
          (m) => _CardBox(
            child: ListTile(
              leading: const Icon(Icons.medication_liquid_rounded),
              title: Text(m.name),
              subtitle: Text(
                '${m.dosage} • ${m.frequency == MedicineFrequency.daily ? 'Daily' : 'Twice Daily'}',
              ),
            ),
          ),
        )
        .toList();
  }

  Medicine _resolveMedicine(MedicinesState state, String medicineId) {
    return state.medicines.firstWhere(
      (m) => m.id == medicineId,
      orElse: () => Medicine(
        id: medicineId,
        name: 'Unknown',
        dosage: '-',
        startDate: DateTime.now(),
        frequency: MedicineFrequency.daily,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.today, required this.onAdd});

  final DateTime today;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE8DBFF),
          child: Icon(Icons.person_rounded, size: 26, color: Color(0xFF2B1247)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi Ana!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Text(
                'How do you feel today?',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.68),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                formatDate(today),
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.54),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        FilledButton.icon(
          onPressed: onAdd,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF7A3CF3),
          ),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add'),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineSmall);
  }
}

class _CardBox extends StatelessWidget {
  const _CardBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
