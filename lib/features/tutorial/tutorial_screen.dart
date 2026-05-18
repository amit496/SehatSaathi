import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/screen_padding.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({
    super.key,
    required this.strings,
    this.initialTopicIndex,
  });

  final AppStrings strings;
  final int? initialTopicIndex;

  @override
  Widget build(BuildContext context) {
    final topics = _topics(strings);

    return Scaffold(
      appBar: AppBar(title: Text(strings.tutorial)),
      body: ListView(
        padding: pagePadding(context, bottom: 32),
        children: [
          Text(
            strings.tutorialSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            strings.notMedicalAdvice,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.mutedText(context),
            ),
          ),
          const SizedBox(height: 16),
          ...topics.asMap().entries.map(
                (e) => _TopicCard(
                  topic: e.value,
                  initiallyExpanded: initialTopicIndex == e.key,
                ),
              ),
        ],
      ),
    );
  }

  static List<_TutorialTopic> _topics(AppStrings s) => [
        _TutorialTopic(
          icon: Icons.home_outlined,
          title: s.dashboard,
          steps: s.tutorialHomeSteps,
        ),
        _TutorialTopic(
          icon: Icons.medication_outlined,
          title: s.medicine,
          steps: s.tutorialMedicineSteps,
        ),
        _TutorialTopic(
          icon: Icons.water_drop_outlined,
          title: s.water,
          steps: s.tutorialWaterSteps,
        ),
        _TutorialTopic(
          icon: Icons.monitor_heart_outlined,
          title: s.vitals,
          steps: s.tutorialVitalsSteps,
        ),
        _TutorialTopic(
          icon: Icons.family_restroom_outlined,
          title: s.familyProfiles,
          steps: s.tutorialFamilySteps,
        ),
        _TutorialTopic(
          icon: Icons.emergency_outlined,
          title: s.emergencyInfo,
          steps: s.tutorialEmergencySteps,
        ),
        _TutorialTopic(
          icon: Icons.backup_outlined,
          title: s.dataBackup,
          steps: s.tutorialBackupSteps,
        ),
        _TutorialTopic(
          icon: Icons.settings_outlined,
          title: s.settings,
          steps: s.tutorialSettingsSteps,
        ),
      ];
}

class _TutorialTopic {
  const _TutorialTopic({
    required this.icon,
    required this.title,
    required this.steps,
  });

  final IconData icon;
  final String title;
  final List<String> steps;
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.topic,
    this.initiallyExpanded = false,
  });

  final _TutorialTopic topic;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          leading: Icon(topic.icon, color: AppTheme.primaryFor(context)),
          title: Text(
            topic.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: topic.steps
                    .map(
                      (step) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6, right: 10),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryFor(context),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                step,
                                style: const TextStyle(height: 1.45),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
