import 'package:flutter/material.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/brand.dart';
import '../../tutorial/tutorial_screen.dart';

class TutorialSettingsCard extends StatelessWidget {
  const TutorialSettingsCard({
    super.key,
    required this.strings,
    required this.onReplayOnboarding,
  });

  final AppStrings strings;
  final VoidCallback onReplayOnboarding;

  static const _topics = [
    (Icons.home_outlined, 0),
    (Icons.medication_outlined, 1),
    (Icons.water_drop_outlined, 2),
    (Icons.monitor_heart_outlined, 3),
    (Icons.family_restroom_outlined, 4),
    (Icons.emergency_outlined, 5),
    (Icons.backup_outlined, 6),
    (Icons.settings_outlined, 7),
  ];

  void _openGuide(BuildContext context, {int? topicIndex}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TutorialScreen(
          strings: strings,
          initialTopicIndex: topicIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppTheme.primaryFor(context);
    final topicLabels = strings.tutorialTopicLabels;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              gradient: Brand.splashFor(context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.tutorial,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        strings.tutorialSectionHint,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          height: 1.35,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          strings.tutorialTopicCount,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              strings.tutorialBrowseTopics,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_topics.length, (i) {
                final (icon, index) = _topics[i];
                return ActionChip(
                  avatar: Icon(icon, size: 18, color: primary),
                  label: Text(
                    topicLabels[i],
                    style: const TextStyle(fontSize: 13),
                  ),
                  side: BorderSide(
                    color: primary.withValues(alpha: 0.35),
                  ),
                  backgroundColor: primary.withValues(alpha: 0.08),
                  onPressed: () => _openGuide(context, topicIndex: index),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: Icon(Icons.menu_book_rounded, color: primary),
            title: Text(strings.openAppGuide),
            subtitle: Text(strings.tutorialSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openGuide(context),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: Icon(Icons.replay_rounded, color: primary),
            title: Text(strings.showOnboardingAgain),
            subtitle: Text(strings.tutorialReplayHint),
            trailing: const Icon(Icons.chevron_right),
            onTap: onReplayOnboarding,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
