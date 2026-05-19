import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'providers/app_providers.dart';
import 'screens/app_gate.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrapApp();

  SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlay);

  runApp(const ProviderScope(child: SehatSaathiApp()));
}

class SehatSaathiApp extends ConsumerStatefulWidget {
  const SehatSaathiApp({super.key});

  @override
  ConsumerState<SehatSaathiApp> createState() => _SehatSaathiAppState();
}

class _SehatSaathiAppState extends ConsumerState<SehatSaathiApp> {
  @override
  void initState() {
    super.initState();
    NotificationService.setActionHandler(_onNotificationAction);
  }

  Future<void> _onNotificationAction(String actionId, String? payload) async {
    await ref
        .read(appControllerProvider.notifier)
        .handleNotificationAction(actionId, payload);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SehatSaathi',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return ColoredBox(
          color: AppTheme.lightBg,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const AppGate(),
    );
  }
}
