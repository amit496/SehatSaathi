import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/enums.dart';
import '../../data/repositories/health_repository.dart';
import '../../providers/app_providers.dart';
import '../../screens/app_lock_screen.dart';
import '../../services/app_lock_service.dart';
import '../../services/notification_service.dart';
import '../../core/utils/screen_padding.dart';
import '../legal/about_screen.dart';
import '../legal/data_safety_screen.dart';
import '../legal/medical_disclaimer_screen.dart';
import '../legal/permissions_info_screen.dart';
import '../legal/privacy_policy_screen.dart';
import '../legal/terms_of_service_screen.dart';
import 'widgets/tutorial_settings_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(appControllerProvider);
    final ctrl = ref.read(appControllerProvider.notifier);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (snap) {
        final settings = snap?.settings ?? ctrl.settings;
        if (settings == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final s = AppStrings.of(settings.language);

        return Scaffold(
          backgroundColor: AppTheme.lightBg,
          appBar: AppBar(title: Text(s.settings)),
          body: ListView(
            padding: pagePadding(context, bottom: 32),
            children: [
              Text(
                s.privacyTagline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              _section(s.general),
              Card(
                child: ListTile(
                  title: Text(s.chooseLanguage),
                  subtitle: Text(
                    settings.language == AppLanguage.hi ? 'हिंदी' : 'English',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final lang = settings.language == AppLanguage.en
                        ? AppLanguage.hi
                        : AppLanguage.en;
                    await ctrl.setLanguage(lang);
                  },
                ),
              ),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text(s.appLock),
                      subtitle: Text(s.appLockHint),
                      value: settings.appLockEnabled,
                      onChanged: (on) async {
                        if (on) {
                          if (!context.mounted) return;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AppLockScreen(
                                setupMode: true,
                                onUnlocked: () => Navigator.pop(context),
                              ),
                            ),
                          );
                          await ctrl.refresh();
                        } else {
                          await AppLockService.disableLock();
                          await ctrl.refresh();
                        }
                      },
                    ),
                    if (settings.appLockEnabled)
                      ListTile(
                        title: Text(s.changePin),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AppLockScreen(
                                setupMode: true,
                                onUnlocked: () => Navigator.pop(context),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _section(s.tutorial),
              TutorialSettingsCard(
                strings: s,
                onReplayOnboarding: () async {
                  Navigator.of(context, rootNavigator: true)
                      .popUntil((route) => route.isFirst);
                  await ctrl.resetOnboarding();
                },
              ),
              const SizedBox(height: 16),
              _section(s.dataBackup),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.backup_outlined),
                      title: Text(s.backupJson),
                      subtitle: Text(s.backupHint),
                      onTap: () async {
                        try {
                          await ctrl.exportBackup();
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$e')),
                            );
                          }
                        }
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.restore_outlined),
                      title: Text(s.restoreBackup),
                      subtitle: Text(s.restoreHint),
                      onTap: () => _restore(context, ctrl, s),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _section(s.notifications),
              if (!NotificationService.isReady)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    s.notificationRestartHint,
                    style: TextStyle(fontSize: 12, color: AppTheme.primary),
                  ),
                ),
              Card(
                child: ListTile(
                  title: Text(s.snoozeDuration),
                  subtitle: Text('${settings.snoozeMinutes} min'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _snoozeMinutes(context, settings, ctrl, s),
                ),
              ),
              const SizedBox(height: 16),
              _section(s.legal),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: Text(s.about),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openLegal(
                        context,
                        AboutScreen(strings: s),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: Text(s.privacyPolicy),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openLegal(
                        context,
                        PrivacyPolicyScreen(strings: s),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.gavel_outlined),
                      title: Text(s.termsOfService),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openLegal(
                        context,
                        TermsOfServiceScreen(strings: s),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.medical_information_outlined),
                      title: Text(s.medicalDisclaimer),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openLegal(
                        context,
                        MedicalDisclaimerScreen(strings: s),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.security_outlined),
                      title: Text(s.dataSafety),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openLegal(
                        context,
                        DataSafetyScreen(strings: s),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.perm_device_information_outlined),
                      title: Text(s.permissionsInfo),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _openLegal(
                        context,
                        PermissionsInfoScreen(strings: s),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: SwitchListTile(
                  title: Text(s.proDemo),
                  subtitle: Text(s.proDemoHint),
                  value: settings.isPro,
                  onChanged: (v) async {
                    settings.isPro = v;
                    await HealthRepository.instance.updateSettings(settings);
                    await ctrl.refresh();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openLegal(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );

  Future<void> _restore(
    BuildContext context,
    AppController ctrl,
    AppStrings s,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.restoreBackup),
        content: Text(s.restoreConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(s.continueLabel),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result == null) return;

    try {
      final file = result.files.single;
      final raw = file.path != null
          ? await File(file.path!).readAsString()
          : String.fromCharCodes(file.bytes ?? []);
      await ctrl.restoreBackup(raw);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.restoreSuccess)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${s.restoreFailed}: $e')),
        );
      }
    }
  }

  Future<void> _snoozeMinutes(
    BuildContext context,
    dynamic settings,
    AppController ctrl,
    AppStrings s,
  ) async {
    final options = [5, 10, 15, 30];
    final picked = await showDialog<int>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(s.snoozeDuration),
        children: options
            .map(
              (m) => SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, m),
                child: Text('$m min'),
              ),
            )
            .toList(),
      ),
    );
    if (picked == null) return;
    settings.snoozeMinutes = picked;
    await HealthRepository.instance.updateSettings(settings);
    await ctrl.refresh();
  }
}
