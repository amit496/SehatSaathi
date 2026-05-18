import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/screen_padding.dart';
import '../../core/utils/weekly_stats.dart';
import '../../data/models/medicine.dart';
import '../../data/repositories/health_repository.dart';
import '../../providers/app_providers.dart';

class WeeklySummaryScreen extends ConsumerWidget {
  const WeeklySummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snap = ref.watch(appControllerProvider).value;
    if (snap == null) return const SizedBox.shrink();
    final s = snap.strings;
    final repo = HealthRepository.instance;

    return FutureBuilder<List<DayHealthStat>>(
      future: _load(repo, snap.profile.uuid, snap.medicines),
      builder: (context, snapshot) {
        final stats = snapshot.data ?? [];
        return Scaffold(
          appBar: AppBar(title: Text(s.weeklySummary)),
          body: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: pagePadding(context, bottom: 32),
                  children: [
                    Text(
                      s.disclaimer,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.mutedText(context),
                          ),
                    ),
                    const SizedBox(height: 20),
                    _ChartCard(
                      title: s.medicineAdherence,
                      color: AppTheme.primaryFor(context),
                      values: stats.map((e) => e.medicinePercent.toDouble()).toList(),
                      labels: stats.map((e) => DateFormat.E().format(e.date)).toList(),
                    ),
                    const SizedBox(height: 16),
                    _ChartCard(
                      title: s.waterIntake,
                      color: const Color(0xFF0EA5E9),
                      values: stats.map((e) => e.waterPercent.toDouble()).toList(),
                      labels: stats.map((e) => DateFormat.E().format(e.date)).toList(),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Future<List<DayHealthStat>> _load(
    HealthRepository repo,
    String profileUuid,
    List<Medicine> medicines,
  ) async {
    final since = DateOnly.key(
      DateOnly.today().subtract(const Duration(days: 6)),
    );
    final logs = await repo.doseLogsForProfile(profileUuid, limit: 500);
    final water = await repo.waterLogsSince(profileUuid, since);
    return WeeklyStatsBuilder.build(
      dosesForDay: (day) => repo.scheduledDosesForDate(medicines, day),
      allLogs: logs,
      waterLogs: water,
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.title,
    required this.color,
    required this.values,
    required this.labels,
  });

  final String title;
  final Color color;
  final List<double> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                maxY: 100,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final i = v.toInt();
                        if (i < 0 || i >= labels.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            labels[i],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < values.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: values[i],
                          color: color,
                          width: 16,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
