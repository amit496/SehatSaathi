import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  static const _inhale = Duration(seconds: 4);
  static const _hold = Duration(seconds: 4);
  static const _exhale = Duration(seconds: 6);

  String _phase = 'Inhale';
  Timer? _timer;
  int _cycle = 0;

  @override
  void initState() {
    super.initState();
    _runPhase();
  }

  void _runPhase() {
    _timer?.cancel();
    Duration next;
    String label;
    if (_phase == 'Inhale') {
      next = _inhale;
      label = 'Hold';
    } else if (_phase == 'Hold') {
      next = _hold;
      label = 'Exhale';
    } else {
      next = _exhale;
      label = 'Inhale';
      _cycle++;
    }
    _timer = Timer(next, () {
      if (!mounted) return;
      setState(() => _phase = label);
      _runPhase();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(title: const Text('Breathing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _phase,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text('Cycle $_cycle'),
            const SizedBox(height: 24),
            const Text(
              'Not medical treatment — for relaxation only.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
