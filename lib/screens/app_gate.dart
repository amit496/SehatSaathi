import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import '../services/app_lock_service.dart';
import '../services/notification_service.dart';
import 'app_lock_screen.dart';
import 'main_shell.dart';
import 'onboarding_screen.dart';
import 'splash_screen.dart';

class AppGate extends ConsumerStatefulWidget {
  const AppGate({super.key});

  @override
  ConsumerState<AppGate> createState() => _AppGateState();
}

class _AppGateState extends ConsumerState<AppGate> with WidgetsBindingObserver {
  static const _minSplash = Duration(milliseconds: 900);
  static const _maxSplash = Duration(seconds: 8);

  bool _showSplash = true;
  bool _minSplashElapsed = false;
  bool _unlocked = true;
  bool _checkingLock = true;
  bool _permissionsRequested = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(_minSplash, () {
      if (!mounted) return;
      setState(() => _minSplashElapsed = true);
      _tryLeaveSplash();
    });
    Future.delayed(_maxSplash, () {
      if (!mounted || !_showSplash) return;
      setState(() => _minSplashElapsed = true);
      _leaveSplash();
    });
    _evaluateLock();
  }

  Future<void> _evaluateLock() async {
    final enabled = await AppLockService.isLockEnabled();
    if (!mounted) return;
    setState(() {
      _checkingLock = false;
      _unlocked = !enabled;
    });
    _tryLeaveSplash();
  }

  void _tryLeaveSplash() {
    if (!_minSplashElapsed || _checkingLock || !_showSplash) return;
    final async = ref.read(appControllerProvider);
    if (async.isLoading && !async.hasError) return;
    _leaveSplash();
  }

  void _leaveSplash() {
    if (!mounted || !_showSplash) return;
    setState(() => _showSplash = false);
    if (!_permissionsRequested) {
      _permissionsRequested = true;
      NotificationService.requestPermissions();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _showSplash) {
      _leaveSplash();
    }
    if (state == AppLifecycleState.resumed) {
      AppLockService.isLockEnabled().then((enabled) {
        if (!mounted || !enabled) return;
        setState(() => _unlocked = false);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<DashboardSnapshot?>>(
      appControllerProvider,
      (_, next) {
        if (!next.isLoading || next.hasError) {
          _tryLeaveSplash();
        }
      },
    );

    if (_showSplash || _checkingLock) {
      return const SplashScreen();
    }

    if (!_unlocked) {
      return AppLockScreen(
        onUnlocked: () => setState(() => _unlocked = true),
      );
    }

    final async = ref.watch(appControllerProvider);

    if (async.hasError) {
      return _BootstrapError(
        message: '${async.error}',
        onRetry: () => ref.read(appControllerProvider.notifier).refresh(),
      );
    }

    if (async.isLoading) {
      return const _AppBootstrapLoader();
    }

    final snap = async.value;
    if (snap == null) {
      return const OnboardingScreen();
    }

    return const MainShell();
  }
}

class _AppBootstrapLoader extends StatelessWidget {
  const _AppBootstrapLoader();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class _BootstrapError extends StatelessWidget {
  const _BootstrapError({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Could not load your health data',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onRetry,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
