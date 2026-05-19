import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
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
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardScreen(onSelectTab: _selectTab),
      MedicineScreen(onBack: _goHome),
      WaterScreen(onBack: _goHome),
      VitalsScreen(onBack: _goHome),
      MoreScreen(onBack: _goHome),
    ];
  }

  void _goHome() => setState(() => _index = 0);

  void _selectTab(int index) {
    if (index < 0 || index >= _pages.length) return;
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final labels = ref.watch(
      appControllerProvider.select((a) => a.value?.strings),
    );

    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome();
      },
      child: Scaffold(
        backgroundColor: AppTheme.lightBg,
        body: IndexedStack(index: _index, children: _pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _selectTab,
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
