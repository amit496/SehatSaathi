import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_providers.dart';

/// Full-screen shell while app data is loading or unavailable (avoids black/empty UI).
class AppDataScaffold extends ConsumerWidget {
  const AppDataScaffold({
    super.key,
    required this.builder,
    this.appBar,
  });

  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context, DashboardSnapshot snap) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(appControllerProvider);

    return async.when(
      skipLoadingOnReload: true,
      loading: () => Scaffold(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: appBar,
        body: Center(child: Text('$e')),
      ),
      data: (snap) {
        if (snap == null) {
          return Scaffold(
            appBar: appBar,
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return builder(context, snap);
      },
    );
  }
}
