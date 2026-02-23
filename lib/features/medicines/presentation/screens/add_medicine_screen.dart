import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/entities/medicine.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key, required this.onSave});

  final Future<void> Function(
    String name,
    String dosage,
    MedicineFrequency frequency,
    String? instructions,
  )
  onSave;

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _doseCtrl = TextEditingController();
  final _instructionsCtrl = TextEditingController();

  MedicineFrequency _frequency = MedicineFrequency.daily;
  String _doseUnit = 'tablet';
  String _foodTiming = 'Before food';
  final List<TimeOfDay> _times = [const TimeOfDay(hour: 8, minute: 0)];
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _doseCtrl.dispose();
    _instructionsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC78EF8), Color(0xFFD7EAFF), Color(0xFFEFF3F7)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Add Medicine',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.84),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1E7FF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.medication_rounded,
                              size: 30,
                              color: Color(0xFF7A3CF3),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medicine details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Add name, dose, schedule and food timing',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Pill name',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _nameCtrl,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? 'Enter medicine name'
                          : null,
                      decoration: const InputDecoration(
                        hintText: 'Enter medicine name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Dose',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = constraints.maxWidth < 360;
                        final amountField = TextFormField(
                          controller: _doseCtrl,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? 'Enter amount'
                              : null,
                          decoration: const InputDecoration(hintText: 'Amount'),
                        );
                        final unitField = DropdownButtonFormField<String>(
                          initialValue: _doseUnit,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'tablet',
                              child: Text('tablet'),
                            ),
                            DropdownMenuItem(
                              value: 'capsule',
                              child: Text('capsule'),
                            ),
                            DropdownMenuItem(value: 'ml', child: Text('ml')),
                            DropdownMenuItem(
                              value: 'drop',
                              child: Text('drop'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _doseUnit = value);
                            }
                          },
                          decoration: const InputDecoration(hintText: 'Unit'),
                        );

                        if (isCompact) {
                          return Column(
                            children: [
                              amountField,
                              const SizedBox(height: 10),
                              unitField,
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(flex: 2, child: amountField),
                            const SizedBox(width: 10),
                            Expanded(child: unitField),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Frequency',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    SegmentedButton<MedicineFrequency>(
                      segments: const [
                        ButtonSegment(
                          value: MedicineFrequency.daily,
                          label: Text('Daily'),
                        ),
                        ButtonSegment(
                          value: MedicineFrequency.twiceDaily,
                          label: Text('Twice daily'),
                        ),
                      ],
                      selected: {_frequency},
                      onSelectionChanged: (value) {
                        setState(() => _frequency = value.first);
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Time',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._times.asMap().entries.map(
                          (entry) => InputChip(
                            label: Text(_formatTime(entry.value)),
                            onPressed: () => _editTime(entry.key),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: _times.length == 1
                                ? null
                                : () {
                                    setState(() {
                                      _times.removeAt(entry.key);
                                    });
                                  },
                          ),
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.add, size: 18),
                          label: const Text('Add time'),
                          onPressed: _pickTime,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Food timing',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'Before food',
                          label: Text('Before food'),
                        ),
                        ButtonSegment(
                          value: 'After food',
                          label: Text('After food'),
                        ),
                      ],
                      selected: {_foodTiming},
                      onSelectionChanged: (value) {
                        setState(() => _foodTiming = value.first);
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Notes (optional)',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    AppTextField(
                      controller: _instructionsCtrl,
                      label: 'e.g. avoid taking with coffee',
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      label: _saving ? 'Saving...' : 'Add Medicine',
                      onPressed: _saving
                          ? null
                          : () async {
                              if (!_formKey.currentState!.validate()) return;
                              setState(() => _saving = true);

                              final sortedTimes = [..._times]
                                ..sort((a, b) {
                                  final am = a.hour * 60 + a.minute;
                                  final bm = b.hour * 60 + b.minute;
                                  return am.compareTo(bm);
                                });

                              if (_frequency == MedicineFrequency.twiceDaily &&
                                  sortedTimes.length < 2) {
                                setState(() => _saving = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Add at least 2 times for twice daily.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final effectiveTimes =
                                  _frequency == MedicineFrequency.daily
                                  ? [sortedTimes.first]
                                  : sortedTimes.take(2).toList();

                              final dosage =
                                  '${_doseCtrl.text.trim()} $_doseUnit';
                              final note = _instructionsCtrl.text.trim();
                              final scheduleText = effectiveTimes
                                  .map(_formatTime)
                                  .join(', ');
                              final instructions = [
                                _foodTiming,
                                if (note.isNotEmpty) note,
                                'Time: $scheduleText',
                              ].join(' | ');

                              await widget.onSave(
                                _nameCtrl.text.trim(),
                                dosage,
                                _frequency,
                                instructions,
                              );
                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;

    final exists = _times.any(
      (time) => time.hour == picked.hour && time.minute == picked.minute,
    );
    if (exists) return;

    setState(() {
      _times.add(picked);
    });
  }

  Future<void> _editTime(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _times[index],
    );
    if (picked == null) return;

    final exists = _times.asMap().entries.any(
      (entry) =>
          entry.key != index &&
          entry.value.hour == picked.hour &&
          entry.value.minute == picked.minute,
    );
    if (exists) return;

    setState(() {
      _times[index] = picked;
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
