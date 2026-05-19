import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/meal_timing_labels.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/utils/screen_padding.dart';
import '../../data/models/enums.dart';
import '../../data/models/medicine.dart';
import '../../data/repositories/health_repository.dart';
import '../../providers/app_providers.dart';
import 'medicine_detail_screen.dart';
import 'medicine_form_screen.dart';
import 'medicine_history_screen.dart';

class MedicineScreen extends ConsumerWidget {
  const MedicineScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  void _handleBack(BuildContext context) {
    if (onBack != null) {
      onBack!();
    } else if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  bool _showBack(BuildContext context) =>
      onBack != null || Navigator.canPop(context);

  void _openHistory(BuildContext context, List<Medicine> medicines, AppStrings s) {
    if (medicines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.addMedicineFirst)),
      );
      return;
    }

    if (medicines.length == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MedicineHistoryScreen(medicine: medicines.first),
        ),
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Text(
                s.chooseMedicineForHistory,
                style: Theme.of(ctx).textTheme.titleMedium,
              ),
            ),
            ...medicines.map(
              (m) => ListTile(
                leading: const Icon(Icons.medication_outlined),
                title: Text(m.name),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MedicineHistoryScreen(medicine: m),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(appControllerProvider);

    return async.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (snap) {
        if (snap == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final s = snap.strings;
        final bottomInset = systemBottomInset(context);

        return Scaffold(
          appBar: AppBar(
            leading: _showBack(context)
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => _handleBack(context),
                  )
                : null,
            title: Text(s.medicine),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton.small(
                  heroTag: 'med_history',
                  tooltip: s.medicineHistory,
                  onPressed: () => _openHistory(context, snap.medicines, s),
                  child: const Icon(Icons.calendar_month_outlined),
                ),
                const SizedBox(height: 8),
                FloatingActionButton.extended(
                  heroTag: 'med_add',
                  onPressed: () => _openForm(context, snap.profile.uuid),
                  icon: const Icon(Icons.add),
                  label: Text(s.addMedicine),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 140 + bottomInset),
            children: [
              Text(
                s.privacyTagline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              if (snap.medicines.isEmpty)
                Text(s.isHindi ? 'कोई दवा नहीं' : 'No medicines yet')
              else
                ...snap.medicines.map(
                  (m) => _MedicineCard(
                    medicine: m,
                    scheduled: snap.scheduledDoses
                        .where((d) => d.medicine.id == m.id)
                        .toList(),
                    strings: s,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MedicineDetailScreen(medicine: m),
                      ),
                    ),
                    onTaken: (dose) => ref
                        .read(appControllerProvider.notifier)
                        .updateDoseStatus(dose, DoseStatus.taken),
                    onSkipped: (dose) => ref
                        .read(appControllerProvider.notifier)
                        .updateDoseStatus(dose, DoseStatus.skipped),
                    onSnooze: (dose) => ref
                        .read(appControllerProvider.notifier)
                        .snoozeDose(dose),
                    onHistory: () => _openHistory(context, [m], s),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _openForm(BuildContext context, String profileUuid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedicineFormScreen(profileUuid: profileUuid),
      ),
    );
  }
}

class _MedicineCard extends StatelessWidget {
  const _MedicineCard({
    required this.medicine,
    required this.scheduled,
    required this.strings,
    required this.onTap,
    required this.onTaken,
    required this.onSkipped,
    required this.onSnooze,
    required this.onHistory,
  });

  final Medicine medicine;
  final List<ScheduledDose> scheduled;
  final AppStrings strings;
  final VoidCallback onTap;
  final void Function(ScheduledDose dose) onTaken;
  final void Function(ScheduledDose dose) onSkipped;
  final void Function(ScheduledDose dose) onSnooze;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (medicine.photoPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(medicine.photoPath!),
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                )
              else
                CircleAvatar(
                  child: Icon(
                    Icons.medication,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${medicine.dose} • ${medicine.times.join(', ')}',
                    ),
                    Text(
                      MealTimingLabels.label(medicine.mealTiming, strings),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (scheduled.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: [
                          TextButton(
                            onPressed: () => onTaken(scheduled.first),
                            child: Text(strings.markTaken),
                          ),
                          TextButton(
                            onPressed: () => onSkipped(scheduled.first),
                            child: Text(strings.markSkipped),
                          ),
                          IconButton(
                            tooltip: strings.snooze,
                            icon: const Icon(Icons.snooze, size: 20),
                            onPressed: () => onSnooze(scheduled.first),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                tooltip: strings.medicineHistory,
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: onHistory,
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
