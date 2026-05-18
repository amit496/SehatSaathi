import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/screen_padding.dart';
import '../../providers/app_providers.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snap = ref.watch(appControllerProvider).value;
    if (snap == null) return const SizedBox.shrink();
    final s = snap.strings;
    final export = ref.watch(exportServiceProvider);

    return Scaffold(
      appBar: AppBar(title: Text(s.healthReports)),
      body: ListView(
        padding: pagePadding(context, bottom: 32),
        children: [
          Text(
            s.disclaimer,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: Text(s.exportPdf),
              subtitle: Text(snap.settings.isPro ? '' : s.proFeature),
              onTap: () => _export(
                context,
                () => export.sharePdf(
                  profileUuid: snap.profile.uuid,
                  profileName: snap.profile.name,
                  isPro: snap.settings.isPro,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.table_chart_outlined),
              title: Text(s.exportCsv),
              subtitle: Text(snap.settings.isPro ? '' : s.proFeature),
              onTap: () => _export(
                context,
                () => export.shareCsv(
                  profileUuid: snap.profile.uuid,
                  profileName: snap.profile.name,
                  isPro: snap.settings.isPro,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _export(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().contains('pro_required')
                ? 'Available in Pro'
                : 'Export failed: $e',
          ),
        ),
      );
    }
  }
}
