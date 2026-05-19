import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/app_providers.dart';
import '../../widgets/progress_ring.dart';
import '../../widgets/screen_header.dart';

class WaterScreen extends ConsumerWidget {
  const WaterScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(appControllerProvider);
    final ctrl = ref.read(appControllerProvider.notifier);

    return async.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (snap) {
        if (snap == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final s = snap.strings;
        final settings = snap.settings;
        final progress = snap.water.goalMl > 0
            ? snap.water.consumedMl / snap.water.goalMl
            : 0.0;

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            children: [
              ScreenHeader(title: s.water, subtitle: s.dailyGoal, onBack: onBack),
              const SizedBox(height: 24),
              Center(
                child: ProgressRing(
                  progress: progress,
                  label: '${(progress * 100).round()}%',
                  size: 120,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${snap.water.consumedMl} / ${snap.water.goalMl} ${s.ml}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  for (final ml in [150, 250, 500])
                    FilledButton.tonal(
                      onPressed: () => ctrl.addWater(ml),
                      child: Text('+$ml ${s.ml}'),
                    ),
                  OutlinedButton(
                    onPressed: () => _customAmount(context, ctrl, s),
                    child: Text(s.customAmount),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => _setGoal(context, ctrl, snap.water.goalMl, s),
                icon: const Icon(Icons.flag_outlined),
                label: Text(s.changeGoal),
              ),
              const SizedBox(height: 20),
              Card(
                child: SwitchListTile(
                  title: Text(s.waterReminders),
                  subtitle: Text(
                    settings.waterReminderTimes.join(', '),
                  ),
                  value: settings.waterRemindersEnabled,
                  onChanged: (v) => ctrl.setWaterReminders(enabled: v),
                ),
              ),
              if (settings.waterRemindersEnabled)
                ListTile(
                  title: Text(s.editReminderTimes),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _editTimes(context, ctrl, settings.waterReminderTimes, s),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _customAmount(
    BuildContext context,
    AppController ctrl,
    dynamic s,
  ) async {
    final controller = TextEditingController();
    final ml = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.customAmount),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(suffixText: s.ml),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, int.tryParse(controller.text)),
            child: Text(s.save),
          ),
        ],
      ),
    );
    if (ml != null && ml > 0) await ctrl.addWater(ml);
  }

  Future<void> _setGoal(
    BuildContext context,
    AppController ctrl,
    int current,
    dynamic s,
  ) async {
    final controller = TextEditingController(text: '$current');
    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.changeGoal),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, int.tryParse(controller.text)),
            child: Text(s.save),
          ),
        ],
      ),
    );
    if (result != null && result > 0) await ctrl.setWaterGoal(result);
  }

  Future<void> _editTimes(
    BuildContext context,
    AppController ctrl,
    List<String> times,
    dynamic s,
  ) async {
    final list = List<String>.from(times);
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(s.editReminderTimes,
                    style: Theme.of(context).textTheme.titleMedium),
                ...list.map(
                  (t) => ListTile(
                    title: Text(t),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setModalState(() => list.remove(t));
                      },
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time == null) return;
                    setModalState(() {
                      list.add(
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                      );
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: Text(s.isHindi ? 'समय' : 'Add time'),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () async {
                    await ctrl.setWaterReminders(
                      enabled: true,
                      times: list,
                    );
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: Text(s.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
