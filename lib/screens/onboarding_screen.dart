import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/l10n/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/brand.dart';
import '../data/models/enums.dart';
import '../providers/app_providers.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/sehat_logo.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;
  AppLanguage _language = AppLanguage.en;
  final _name = TextEditingController();
  ProfileRelation _relation = ProfileRelation.self;
  bool _waterReminders = true;
  bool _completing = false;

  @override
  void dispose() {
    _pageController.dispose();
    _name.dispose();
    super.dispose();
  }

  AppStrings get _s => AppStrings.of(_language);

  Future<void> _complete() async {
    if (_completing) return;
    setState(() => _completing = true);
    try {
      await ref.read(appControllerProvider.notifier).completeOnboarding(
            language: _language,
            name: _name.text.trim().isEmpty ? 'User' : _name.text.trim(),
            relation: _relation,
            enableWaterReminders: _waterReminders,
          );
    } catch (e) {
      if (!mounted) return;
      setState(() => _completing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _s.isHindi
                ? 'सेटअप पूरा नहीं हो सका। फिर कोशिश करें।'
                : 'Could not finish setup. Please try again.',
          ),
        ),
      );
    }
  }

  Future<void> _skip() async {
    await _complete();
  }

  Future<void> _finish() async {
    if (_page == 2 && _name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _s.isHindi ? 'कृपया नाम दर्ज करें' : 'Please enter your name',
          ),
        ),
      );
      return;
    }
    if (_page < 3) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      return;
    }
    await _complete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _skip,
                child: Text(_s.skip),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) => setState(() => _page = i),
              children: [
                _WelcomePage(strings: _s),
                _LanguagePage(
                  language: _language,
                  onChanged: (l) => setState(() => _language = l),
                  strings: _s,
                ),
                _ProfilePage(
                  nameController: _name,
                  relation: _relation,
                  onRelationChanged: (r) => setState(() => _relation = r),
                  strings: _s,
                ),
                _RemindersPage(
                  waterEnabled: _waterReminders,
                  onChanged: (v) => setState(() => _waterReminders = v),
                  strings: _s,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (i) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _page == i
                      ? AppTheme.primaryFor(context)
                      : AppTheme.mutedText(context).withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          BottomActionBar(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _completing ? null : _finish,
                child: _completing
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_page < 3 ? _s.next : _s.getStarted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: Brand.splashFor(context),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const SehatLogo(size: 64, whiteOnBrand: true),
          ),
          const SizedBox(height: 40),
          Text(
            strings.appName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            strings.tagline,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            strings.privacyTagline,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.mutedText(context)),
          ),
        ],
      ),
    );
  }
}

class _LanguagePage extends StatelessWidget {
  const _LanguagePage({
    required this.language,
    required this.onChanged,
    required this.strings,
  });

  final AppLanguage language;
  final ValueChanged<AppLanguage> onChanged;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            strings.chooseLanguage,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          RadioListTile<AppLanguage>(
            title: const Text('English'),
            value: AppLanguage.en,
            groupValue: language,
            onChanged: (v) => onChanged(v ?? language),
          ),
          RadioListTile<AppLanguage>(
            title: const Text('हिंदी'),
            value: AppLanguage.hi,
            groupValue: language,
            onChanged: (v) => onChanged(v ?? language),
          ),
        ],
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({
    required this.nameController,
    required this.relation,
    required this.onRelationChanged,
    required this.strings,
  });

  final TextEditingController nameController;
  final ProfileRelation relation;
  final ValueChanged<ProfileRelation> onRelationChanged;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            strings.addProfile,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: strings.profileName),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<ProfileRelation>(
            initialValue: relation,
            decoration: InputDecoration(labelText: strings.relation),
            items: ProfileRelation.values
                .map(
                  (r) => DropdownMenuItem(
                    value: r,
                    child: Text(strings.relationLabel(r)),
                  ),
                )
                .toList(),
            onChanged: (v) => onRelationChanged(v ?? relation),
          ),
        ],
      ),
    );
  }
}

class _RemindersPage extends StatelessWidget {
  const _RemindersPage({
    required this.waterEnabled,
    required this.onChanged,
    required this.strings,
  });

  final bool waterEnabled;
  final ValueChanged<bool> onChanged;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            size: 64,
            color: AppTheme.primaryFor(context),
          ),
          const SizedBox(height: 24),
          Text(
            strings.setupReminders,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: Text(strings.enableWaterReminders),
            subtitle: Text(strings.isHindi ? '09:00, 13:00, 18:00' : '9 AM, 1 PM, 6 PM'),
            value: waterEnabled,
            onChanged: onChanged,
          ),
          const SizedBox(height: 12),
          Text(
            strings.isHindi
                ? 'दवा रिमाइंडर दवा जोड़ने पर सेट होंगे।'
                : 'Medicine reminders are set when you add medicines.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
