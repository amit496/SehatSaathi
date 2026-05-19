import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/date_utils.dart';
import '../../data/models/enums.dart';
import '../../data/models/mood_log.dart';
import '../../data/repositories/health_repository.dart';
import '../../core/utils/screen_padding.dart';
import '../../providers/app_providers.dart';
import '../../widgets/app_data_scaffold.dart';
import 'breathing_screen.dart';

class MoodScreen extends ConsumerStatefulWidget {
  const MoodScreen({super.key});

  @override
  ConsumerState<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends ConsumerState<MoodScreen> {
  List<MoodLog> _history = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final snap = ref.read(appControllerProvider).value;
    if (snap == null) return;
    final logs = await HealthRepository.instance.moodsForProfile(snap.profile.uuid);
    if (mounted) setState(() => _history = logs);
  }

  @override
  Widget build(BuildContext context) {
    return AppDataScaffold(
      appBar: AppBar(
        title: Text(
          ref.watch(appControllerProvider).value?.strings.moodWellness ??
              'Mood',
        ),
      ),
      builder: (context, snap) {
        final s = snap.strings;
        return RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: pagePadding(context, bottom: 32),
          children: [
            Text(
              s.notMedicalAdvice,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              s.isHindi ? 'आज का मूड' : 'How do you feel today?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: MoodLevel.values.map((m) {
                return ActionChip(
                  label: Text(_moodEmoji(m)),
                  onPressed: () => _logMood(context, snap.profile.uuid, m, s),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.air_rounded),
              title: Text(s.isHindi ? 'श्वास अभ्यास' : 'Breathing exercise'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BreathingScreen()),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              s.moodHistory,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (_history.isEmpty)
              Text(s.isHindi ? 'कोई रिकॉर्ड नहीं' : 'No entries yet')
            else
              ..._history.map(
                (log) => Card(
                  child: ListTile(
                    leading: Text(_moodEmoji(log.mood), style: const TextStyle(fontSize: 28)),
                    title: Text(log.mood.name),
                    subtitle: Text(
                      log.note.isNotEmpty
                          ? log.note
                          : DateFormat.MMMd().format(log.createdAt),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
      },
    );
  }

  String _moodEmoji(MoodLevel m) => switch (m) {
        MoodLevel.veryLow => '😔',
        MoodLevel.low => '😐',
        MoodLevel.neutral => '🙂',
        MoodLevel.good => '😊',
        MoodLevel.great => '😄',
      };

  Future<void> _logMood(
    BuildContext context,
    String profileUuid,
    MoodLevel mood,
    dynamic s,
  ) async {
    final note = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.isHindi ? 'नोट (वैकल्पिक)' : 'Note (optional)'),
        content: TextField(controller: note, maxLines: 3),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(s.save),
          ),
        ],
      ),
    );
    if (ok != true) return;

    final log = MoodLog()
      ..profileUuid = profileUuid
      ..dateKey = DateOnly.key(DateOnly.today())
      ..mood = mood
      ..note = note.text.trim()
      ..createdAt = DateTime.now();

    await HealthRepository.instance.addMood(log);
    await _load();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.isHindi ? 'सहेजा गया' : 'Saved')),
      );
    }
  }
}
