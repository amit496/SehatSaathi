import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/utils/screen_padding.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/enums.dart';
import '../../data/models/health_profile.dart';
import '../../data/models/vitals_log.dart';
import '../../data/repositories/health_repository.dart';
import '../../providers/app_providers.dart';
import '../../widgets/screen_header.dart';

final vitalsProvider =
    FutureProvider.family<List<VitalsLog>, VitalsType>((ref, type) async {
  final snap = ref.watch(appControllerProvider).value;
  if (snap == null) return [];
  return HealthRepository.instance.vitalsFor(snap.profile.uuid, type);
});

class VitalsScreen extends ConsumerStatefulWidget {
  const VitalsScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  ConsumerState<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends ConsumerState<VitalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(appControllerProvider).value;
    if (snap == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final s = snap.strings;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ScreenHeader(
              title: s.vitals,
              subtitle: s.disclaimer,
              onBack: widget.onBack,
            ),
          ),
          TabBar(
            controller: _tabs,
            tabs: [
              Tab(text: s.isHindi ? 'बीपी' : 'BP'),
              Tab(text: s.isHindi ? 'शुगर' : 'Sugar'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _VitalsTab(
                  type: VitalsType.bloodPressure,
                  profile: snap.profile,
                  strings: s,
                ),
                _VitalsTab(
                  type: VitalsType.bloodSugar,
                  profile: snap.profile,
                  strings: s,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VitalsTab extends ConsumerWidget {
  const _VitalsTab({
    required this.type,
    required this.profile,
    required this.strings,
  });

  final VitalsType type;
  final HealthProfile profile;
  final AppStrings strings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(vitalsProvider(type));

    return logsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (logs) {
        return ListView(
          padding: pagePadding(context, bottom: 32),
          children: [
            if (logs.length >= 2)
              SizedBox(
                height: 180,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (var i = 0; i < logs.length; i++)
                            FlSpot(
                              i.toDouble(),
                              type == VitalsType.bloodPressure
                                  ? (logs[i].systolic ?? 0).toDouble()
                                  : (logs[i].sugarMgDl ?? 0),
                            ),
                        ],
                        isCurved: true,
                        color: AppTheme.primaryFor(context),
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ...logs.map((l) => Card(
                  child: ListTile(
                    title: Text(
                      type == VitalsType.bloodPressure
                          ? '${l.systolic}/${l.diastolic} mmHg'
                          : '${l.sugarMgDl} mg/dL',
                    ),
                    subtitle: Text(
                      '${l.recordedAt.day}/${l.recordedAt.month}/${l.recordedAt.year}',
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => _addReading(context, ref),
              icon: const Icon(Icons.add),
              label: Text(
                type == VitalsType.bloodPressure
                    ? strings.logBp
                    : strings.logSugar,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addReading(BuildContext context, WidgetRef ref) async {
    if (type == VitalsType.bloodPressure) {
      final sys = TextEditingController();
      final dia = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Blood pressure'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: sys,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Systolic'),
              ),
              TextField(
                controller: dia,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Diastolic'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Save'),
            ),
          ],
        ),
      );
      if (ok != true) return;
      final log = VitalsLog()
        ..profileUuid = profile.uuid
        ..type = type
        ..systolic = int.tryParse(sys.text)
        ..diastolic = int.tryParse(dia.text)
        ..recordedAt = DateTime.now();
      await HealthRepository.instance.addVitals(log);
    } else {
      final sugar = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Blood sugar (mg/dL)'),
          content: TextField(
            controller: sugar,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Save'),
            ),
          ],
        ),
      );
      if (ok != true) return;
      final log = VitalsLog()
        ..profileUuid = profile.uuid
        ..type = type
        ..sugarMgDl = double.tryParse(sugar.text)
        ..recordedAt = DateTime.now();
      await HealthRepository.instance.addVitals(log);
    }
    ref.invalidate(vitalsProvider);
  }
}
