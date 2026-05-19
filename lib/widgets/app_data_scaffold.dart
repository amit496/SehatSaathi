import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../providers/app_providers.dart';

/// Full-screen shell with a light background on every route.
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
      loading: () => _page(
        appBar: appBar,
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => _page(
        appBar: appBar,
        body: Center(child: Text('$e')),
      ),
      data: (snap) {
        if (snap == null) {
          return _page(
            appBar: appBar,
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return _page(
          appBar: appBar,
          body: builder(context, snap),
        );
      },
    );
  }

  static Scaffold _page({
    PreferredSizeWidget? appBar,
    required Widget body,
  }) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: appBar,
      body: body,
    );
  }
}
