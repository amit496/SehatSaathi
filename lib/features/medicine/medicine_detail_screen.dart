import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/meal_timing_labels.dart';
import '../../data/models/enums.dart';
import '../../data/models/medicine.dart';
import '../../providers/app_providers.dart';
import '../../widgets/app_data_scaffold.dart';
import 'medicine_form_screen.dart';
import 'medicine_history_screen.dart';

class MedicineDetailScreen extends ConsumerWidget {
  const MedicineDetailScreen({
    super.key,
    required this.medicine,
  });

  final Medicine medicine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppDataScaffold(
      builder: (context, snap) {
        final s = snap.strings;
        final scheduled = snap.scheduledDoses
            .where((d) => d.medicine.id == medicine.id)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(medicine.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MedicineFormScreen(
                      profileUuid: medicine.profileUuid,
                      medicine: medicine,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (medicine.photoPath != null &&
              File(medicine.photoPath!).existsSync())
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(medicine.photoPath!),
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          const SizedBox(height: 16),
          _InfoRow(label: s.isHindi ? 'खुराक' : 'Dose', value: medicine.dose),
          _InfoRow(
            label: s.isHindi ? 'भोजन' : 'Meal',
            value: MealTimingLabels.label(medicine.mealTiming, s),
          ),
          if (medicine.mealNote.isNotEmpty)
            _InfoRow(label: s.isHindi ? 'नोट' : 'Note', value: medicine.mealNote),
          _InfoRow(
            label: s.isHindi ? 'समय' : 'Times',
            value: medicine.times.join(', '),
          ),
          if (medicine.refillAlertEnabled && medicine.refillDaysLeft != null)
            _InfoRow(
              label: s.refillReminder,
              value: '${medicine.refillDaysLeft} ${s.isHindi ? 'दिन' : 'days'}',
            ),
          const SizedBox(height: 16),
          Text(
            s.isHindi ? 'आज की खुराक' : "Today's doses",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (scheduled.isEmpty)
            Text(s.isHindi ? 'आज कोई खुराक नहीं' : 'No doses today')
          else
            ...scheduled.map((dose) {
              final log = snap.doseLogs.where(
                (l) =>
                    l.medicineId == dose.medicine.id &&
                    l.scheduledTime == dose.scheduledTime,
              );
              final status = log.isEmpty ? DoseStatus.pending : log.first.status;

              return Card(
                child: ListTile(
                  title: Text(dose.scheduledTime),
                  subtitle: Text(status.name),
                  trailing: status == DoseStatus.pending
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: s.snooze,
                              icon: const Icon(Icons.snooze),
                              onPressed: () => ref
                                  .read(appControllerProvider.notifier)
                                  .snoozeDose(dose),
                            ),
                            IconButton(
                              icon: const Icon(Icons.check_circle_outline),
                              color: Colors.green,
                              onPressed: () => ref
                                  .read(appControllerProvider.notifier)
                                  .updateDoseStatus(dose, DoseStatus.taken),
                            ),
                          ],
                        )
                      : null,
                ),
              );
            }),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MedicineHistoryScreen(medicine: medicine),
              ),
            ),
            icon: const Icon(Icons.calendar_month_outlined),
            label: Text(s.medicineHistory),
          ),
        ],
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
