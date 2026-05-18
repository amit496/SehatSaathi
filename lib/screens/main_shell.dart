import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/bp_log/vitals_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/medicine/medicine_screen.dart';
import '../features/water/water_screen.dart';
import '../providers/app_providers.dart';
import 'more_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _index = 0;

  void _goHome() => setState(() => _index = 0);

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(appControllerProvider).value;
    final labels = snap?.strings;

    final pages = [
      const DashboardScreen(),
      MedicineScreen(onBack: _goHome),
      WaterScreen(onBack: _goHome),
      VitalsScreen(onBack: _goHome),
      MoreScreen(onBack: _goHome),
    ];

    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome();
      },
      child: Scaffold(
        body: IndexedStack(index: _index, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_rounded),
              label: labels?.dashboard ?? 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.medication_outlined),
              selectedIcon: const Icon(Icons.medication_rounded),
              label: labels?.medicine ?? 'Medicine',
            ),
            NavigationDestination(
              icon: const Icon(Icons.water_drop_outlined),
              selectedIcon: const Icon(Icons.water_drop_rounded),
              label: labels?.water ?? 'Water',
            ),
            NavigationDestination(
              icon: const Icon(Icons.monitor_heart_outlined),
              selectedIcon: const Icon(Icons.monitor_heart_rounded),
              label: labels?.vitals ?? 'Vitals',
            ),
            NavigationDestination(
              icon: const Icon(Icons.apps_outlined),
              selectedIcon: const Icon(Icons.apps_rounded),
              label: labels?.more ?? 'More',
            ),
          ],
        ),
      ),
    );
  }
}
