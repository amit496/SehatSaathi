import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/enums.dart';
import '../../data/models/health_profile.dart';
import '../../core/utils/screen_padding.dart';
import '../../providers/app_providers.dart';

class FamilyScreen extends ConsumerWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(appControllerProvider.notifier);
    final profiles = ctrl.profiles;
    final snap = ref.watch(appControllerProvider).value;
    final s = snap?.strings;

    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(
        title: Text(s?.familyProfiles ?? 'Family profiles'),
      ),
      body: ListView(
        padding: pagePadding(context, bottom: 32),
        children: [
          if (s?.privacyTagline != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                s!.privacyTagline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ...profiles.map(
            (p) {
              final active = snap?.profile.uuid == p.uuid;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(p.name.isNotEmpty ? p.name[0].toUpperCase() : '?'),
                  ),
                  title: Text(p.name),
                  subtitle: Text(s?.relationLabel(p.relation) ?? p.relation.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (active)
                        Icon(Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary),
                      PopupMenuButton<String>(
                        onSelected: (action) async {
                          if (action == 'edit') {
                            await _editProfile(context, ctrl, p, s);
                          } else if (action == 'delete') {
                            await _confirmDelete(context, ctrl, p, s);
                          }
                        },
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text(s?.editProfile ?? 'Edit'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(s?.deleteProfile ?? 'Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () => ctrl.setActiveProfile(p.uuid),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _addProfile(context, ctrl, s),
            icon: const Icon(Icons.person_add_outlined),
            label: Text(s?.addProfile ?? 'Add profile'),
          ),
        ],
      ),
    );
  }

  Future<void> _addProfile(
    BuildContext context,
    AppController ctrl,
    dynamic s,
  ) async {
    final result = await _profileDialog(context, s, title: s?.addProfile);
    if (result == null) return;

    try {
      await ctrl.saveProfile(
        name: result.$1,
        relation: result.$2,
      );
    } catch (e) {
      if (context.mounted && e.toString().contains('profile_limit')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s?.proFeature ?? 'Pro required')),
        );
      }
    }
  }

  Future<void> _editProfile(
    BuildContext context,
    AppController ctrl,
    HealthProfile profile,
    dynamic s,
  ) async {
    final result = await _profileDialog(
      context,
      s,
      title: s?.editProfile,
      initialName: profile.name,
      initialRelation: profile.relation,
    );
    if (result == null) return;

    await ctrl.saveProfile(
      existing: profile,
      name: result.$1,
      relation: result.$2,
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    AppController ctrl,
    HealthProfile profile,
    dynamic s,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s?.deleteProfile ?? 'Delete profile'),
        content: Text(
          s?.isHindi == true
              ? '${profile.name} और उनका सारा डेटा हटाएँ?'
              : 'Delete ${profile.name} and all their data?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(s?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(s?.deleteProfile ?? 'Delete'),
          ),
        ],
      ),
    );
    if (ok == true) await ctrl.deleteProfile(profile.uuid);
  }

  Future<(String, ProfileRelation)?> _profileDialog(
    BuildContext context,
    dynamic s, {
    String? title,
    String? initialName,
    ProfileRelation? initialRelation,
  }) async {
    final name = TextEditingController(text: initialName ?? '');
    var relation = initialRelation ?? ProfileRelation.other;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(title ?? s?.addProfile ?? 'Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: s?.profileName ?? 'Name',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ProfileRelation>(
                initialValue: relation,
                decoration: InputDecoration(
                  labelText: s?.relation ?? 'Relation',
                ),
                items: ProfileRelation.values
                    .map(
                      (r) => DropdownMenuItem(
                        value: r,
                        child: Text(s?.relationLabel(r) ?? r.name),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => relation = v ?? relation),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(s?.cancel ?? 'Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(s?.save ?? 'Save'),
            ),
          ],
        ),
      ),
    );

    if (ok != true || name.text.trim().isEmpty) return null;
    return (name.text.trim(), relation);
  }
}
