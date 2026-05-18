import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/doctor/doctor_visits_screen.dart';
import '../features/emergency/emergency_screen.dart';
import '../features/family/family_screen.dart';
import '../features/mood/mood_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/tutorial/tutorial_screen.dart';
import '../core/l10n/app_strings.dart';
import '../data/models/enums.dart';
import '../providers/app_providers.dart';
import '../widgets/screen_header.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snap = ref.watch(appControllerProvider).value;
    final s = snap?.strings;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          ScreenHeader(
            title: s?.more ?? 'More',
            subtitle: s?.privacyTagline,
            onBack: onBack,
          ),
          const SizedBox(height: 8),
          _tile(
            context,
            icon: Icons.family_restroom_outlined,
            title: s?.familyProfiles ?? 'Family profiles',
            screen: const FamilyScreen(),
          ),
          _tile(
            context,
            icon: Icons.mood_outlined,
            title: s?.moodWellness ?? 'Mood & wellness',
            screen: const MoodScreen(),
          ),
          _tile(
            context,
            icon: Icons.emergency_outlined,
            title: s?.emergencyInfo ?? 'Emergency info',
            screen: const EmergencyScreen(),
          ),
          _tile(
            context,
            icon: Icons.medical_services_outlined,
            title: s?.doctorVisits ?? 'Doctor appointments',
            screen: const DoctorVisitsScreen(),
          ),
          _tile(
            context,
            icon: Icons.description_outlined,
            title: s?.healthReports ?? 'Health reports',
            screen: const ReportsScreen(),
          ),
          _tile(
            context,
            icon: Icons.school_outlined,
            title: s?.tutorial ?? 'App guide',
            screen: TutorialScreen(strings: s ?? AppStrings.of(AppLanguage.en)),
          ),
          _tile(
            context,
            icon: Icons.settings_outlined,
            title: s?.settings ?? 'Settings',
            screen: const SettingsScreen(),
          ),
        ],
      ),
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget screen,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        ),
      ),
    );
  }
}
