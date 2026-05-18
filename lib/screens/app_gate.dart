import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';
import '../services/app_lock_service.dart';
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
  bool _showSplash = true;
  bool _unlocked = true;
  bool _checkingLock = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1400), _leaveSplash);
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
  }

  void _leaveSplash() {
    if (!mounted || !_showSplash) return;
    setState(() => _showSplash = false);
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
    if (_showSplash || _checkingLock) return const SplashScreen();

    if (!_unlocked) {
      return AppLockScreen(
        onUnlocked: () => setState(() => _unlocked = true),
      );
    }

    final async = ref.watch(appControllerProvider);
    return async.when(
      loading: () => const SplashScreen(),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (snap) => snap == null ? const OnboardingScreen() : const MainShell(),
    );
  }
}
