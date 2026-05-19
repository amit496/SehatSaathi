import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/l10n/app_strings.dart';
import '../core/theme/app_theme.dart';
import '../data/models/enums.dart';
import '../services/app_lock_service.dart';
import '../services/isar_service.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({
    super.key,
    required this.onUnlocked,
    this.setupMode = false,
  });

  final VoidCallback onUnlocked;
  final bool setupMode;

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  final _pin = <String>[];
  String? _confirmPin;
  bool _error = false;
  AppStrings _s = AppStrings(AppLanguage.en);

  @override
  void initState() {
    super.initState();
    _loadStrings();
  }

  Future<void> _loadStrings() async {
    final settings = await IsarService.settings();
    if (mounted) setState(() => _s = AppStrings.of(settings.language));
  }

  void _addDigit(String d) {
    if (_pin.length >= 4) return;
    setState(() {
      _error = false;
      _pin.add(d);
    });
    if (_pin.length == 4) {
      Future.microtask(_submit);
    }
  }

  void _backspace() {
    if (_pin.isEmpty) return;
    setState(() {
      _error = false;
      _pin.removeLast();
    });
  }

  Future<void> _submit() async {
    final entered = _pin.join();
    if (widget.setupMode) {
      if (_confirmPin == null) {
        setState(() {
          _confirmPin = entered;
          _pin.clear();
        });
        return;
      }
      if (_confirmPin != entered) {
        setState(() {
          _error = true;
          _confirmPin = null;
          _pin.clear();
        });
        return;
      }
      await AppLockService.setPin(entered);
      widget.onUnlocked();
      return;
    }

    final ok = await AppLockService.verifyPin(entered);
    if (ok) {
      widget.onUnlocked();
    } else {
      setState(() {
        _error = true;
        _pin.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSetup = widget.setupMode;
    final title = isSetup
        ? (_confirmPin == null ? _s.setPin : _s.confirmPin)
        : _s.enterPin;

    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Icon(
                Icons.lock_outline,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              if (_error) ...[
                const SizedBox(height: 8),
                Text(
                  isSetup ? _s.pinMismatch : _s.wrongPin,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (i) => Container(
                    width: 14,
                    height: 14,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < _pin.length
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              _Keypad(onDigit: _addDigit, onBackspace: _backspace),
            ],
          ),
        ),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({required this.onDigit, required this.onBackspace});

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.6,
      ),
      itemCount: keys.length,
      itemBuilder: (context, i) {
        final key = keys[i];
        if (key.isEmpty) return const SizedBox.shrink();
        return TextButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            if (key == '⌫') {
              onBackspace();
            } else {
              onDigit(key);
            }
          },
          child: Text(
            key,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}
