import 'package:flutter/material.dart';

import '../../core/constants/app_info.dart';
import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/sehat_logo.dart';
import 'data_safety_screen.dart';
import 'medical_disclaimer_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(strings.about)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SehatLogo(size: 72),
                  const SizedBox(height: 16),
                  Text(
                    strings.appName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(strings.tagline, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text(
                    '${strings.version} ${AppInfo.versionLabel}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
            child: ListTile(
              leading: Icon(Icons.phone_android, color: theme.colorScheme.primary),
              title: Text(strings.legalInApp),
              subtitle: Text(strings.legalInAppBody),
            ),
          ),
          const SizedBox(height: 12),
          _InfoTile(
            icon: Icons.privacy_tip_outlined,
            title: strings.privacyPolicy,
            subtitle: strings.privacyTagline,
            onTap: () => _open(context, PrivacyPolicyScreen(strings: strings)),
          ),
          _InfoTile(
            icon: Icons.gavel_outlined,
            title: strings.termsOfService,
            onTap: () => _open(context, TermsOfServiceScreen(strings: strings)),
          ),
          _InfoTile(
            icon: Icons.medical_information_outlined,
            title: strings.medicalDisclaimer,
            onTap: () => _open(context, MedicalDisclaimerScreen(strings: strings)),
          ),
          _InfoTile(
            icon: Icons.security_outlined,
            title: strings.dataSafety,
            onTap: () => _open(context, DataSafetyScreen(strings: strings)),
          ),
          _InfoTile(
            icon: Icons.offline_bolt_outlined,
            title: strings.aboutOffline,
            subtitle: strings.aboutOfflineBody,
          ),
          _InfoTile(
            icon: Icons.code_outlined,
            title: strings.openSourceLicenses,
            subtitle: AppInfo.packageId,
            onTap: () => showLicensePage(context: context),
          ),
          const SizedBox(height: 8),
          Text(
            strings.aboutDeveloper,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _ContactRow(label: strings.developer, value: AppInfo.developerName),
          _ContactRow(label: strings.supportEmail, value: AppInfo.supportEmail),
          const SizedBox(height: 12),
          Text(
            strings.aboutPlayStoreNote,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.mutedText(context),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            strings.aboutPlayStoreUrlHint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.mutedText(context),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
        onTap: onTap,
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SelectableText.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
