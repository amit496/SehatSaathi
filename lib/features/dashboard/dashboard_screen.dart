import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/enums.dart';
import '../../providers/app_providers.dart';
import '../../widgets/progress_ring.dart';
import '../../widgets/screen_header.dart';
import '../medicine/medicine_screen.dart';
import '../reports/weekly_summary_screen.dart';
import '../water/water_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(appControllerProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (snap) {
        if (snap == null) return const SizedBox.shrink();
        final s = snap.strings;
        final missed = snap.missedDoses;
        final pending = snap.scheduledDoses.where((d) {
          final log = snap.doseLogs.where(
            (l) =>
                l.medicineId == d.medicine.id &&
                l.scheduledTime == d.scheduledTime,
          );
          return log.isEmpty || log.first.status == DoseStatus.pending;
        }).toList();

        final waterProgress = snap.water.goalMl > 0
            ? snap.water.consumedMl / snap.water.goalMl
            : 0.0;

        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () => ref.read(appControllerProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              children: [
                ScreenHeader(
                  subtitle: s.privacyTagline,
                  title: s.greeting(snap.profile.name),
                ),
                const SizedBox(height: 20),
                _SummaryCard(
                  healthScore: snap.healthScore,
                  waterLabel:
                      '${snap.water.consumedMl}/${snap.water.goalMl} ${s.ml}',
                  waterProgress: waterProgress,
                  medicinePending: pending.length,
                  strings: s,
                ),
                if (missed.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Material(
                    color: AppTheme.danger.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      leading: Icon(Icons.warning_amber_rounded,
                          color: AppTheme.danger),
                      title: Text(
                        s.missedDoses,
                        style: TextStyle(
                          color: AppTheme.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(s.missedDosesCount(missed.length)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MedicineScreen(),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Text(
                  s.upcomingReminders,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (pending.isEmpty)
                  Text(
                    s.isHindi ? 'कोई दवा शेड्यूल नहीं' : 'No medicines scheduled',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                else
                  ...pending.take(4).map(
                        (d) => Card(
                          child: ListTile(
                            leading: const Icon(Icons.medication_rounded),
                            title: Text(d.medicine.name),
                            subtitle: Text(
                              '${d.scheduledTime} • ${d.medicine.dose}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: s.snooze,
                                  icon: const Icon(Icons.snooze),
                                  onPressed: () => ref
                                      .read(appControllerProvider.notifier)
                                      .snoozeDose(d),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.check_circle_outline),
                                  color: AppTheme.success,
                                  onPressed: () => ref
                                      .read(appControllerProvider.notifier)
                                      .updateDoseStatus(d, DoseStatus.taken),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                Text(
                  s.quickActions,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      avatar: const Icon(Icons.medication, size: 18),
                      label: Text(s.addMedicine),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => MedicineScreen(
                            onBack: () => Navigator.pop(ctx),
                          ),
                        ),
                      ),
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.water_drop, size: 18),
                      label: Text(s.logWater),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const WaterScreen()),
                      ),
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.bar_chart, size: 18),
                      label: Text(s.weeklySummary),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WeeklySummaryScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.healthScore,
    required this.waterLabel,
    required this.waterProgress,
    required this.medicinePending,
    required this.strings,
  });

  final int healthScore;
  final String waterLabel;
  final double waterProgress;
  final int medicinePending;
  final dynamic strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.todaySummary,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ProgressRing(
                progress: healthScore / 100,
                label: '$healthScore%',
                size: 96,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.healthScore,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.water_drop_outlined, size: 18),
                        const SizedBox(width: 6),
                        Expanded(child: Text(waterLabel)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(value: waterProgress.clamp(0, 1)),
                    const SizedBox(height: 8),
                    Text(
                      strings.isHindi
                          ? '$medicinePending दवा बाकी'
                          : '$medicinePending medicine pending',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
