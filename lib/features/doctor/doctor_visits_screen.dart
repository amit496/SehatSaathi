import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/utils/screen_padding.dart';
import '../../data/models/doctor_visit.dart';
import '../../data/repositories/health_repository.dart';
import '../../providers/app_providers.dart';
import '../../services/notification_service.dart';
import '../../widgets/bottom_action_bar.dart';

class DoctorVisitsScreen extends ConsumerStatefulWidget {
  const DoctorVisitsScreen({super.key});

  @override
  ConsumerState<DoctorVisitsScreen> createState() => _DoctorVisitsScreenState();
}

class _DoctorVisitsScreenState extends ConsumerState<DoctorVisitsScreen> {
  List<DoctorVisit> _visits = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final snap = ref.read(appControllerProvider).value;
    if (snap == null) return;
    final list = await HealthRepository.instance.allVisits(snap.profile.uuid);
    if (mounted) setState(() => _visits = list);
  }

  Future<void> _addOrEdit({DoctorVisit? existing}) async {
    final snap = ref.read(appControllerProvider).value;
    if (snap == null) return;
    final s = snap.strings;

    final name = TextEditingController(text: existing?.doctorName ?? '');
    final clinic = TextEditingController(text: existing?.clinic ?? '');
    final notes = TextEditingController(text: existing?.notes ?? '');
    var when = existing?.visitAt ?? DateTime.now().add(const Duration(days: 1));

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModal) => AlertDialog(
          title: Text(existing == null ? s.addVisit : s.editMedicine),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(labelText: s.doctorName),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: clinic,
                  decoration: InputDecoration(labelText: s.clinic),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: notes,
                  decoration: InputDecoration(labelText: s.visitNotes),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(s.visitDateTime),
                  subtitle: Text(DateFormat.yMMMd().add_jm().format(when)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: ctx,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      initialDate: when,
                    );
                    if (date == null) return;
                    if (!ctx.mounted) return;
                    final time = await showTimePicker(
                      context: ctx,
                      initialTime: TimeOfDay.fromDateTime(when),
                    );
                    if (time == null) return;
                    setModal(() {
                      when = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        time.hour,
                        time.minute,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(s.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(s.save),
            ),
          ],
        ),
      ),
    );

    if (saved != true || name.text.trim().isEmpty) return;

    final visit = existing ?? DoctorVisit()..profileUuid = snap.profile.uuid;
    visit
      ..doctorName = name.text.trim()
      ..clinic = clinic.text.trim()
      ..notes = notes.text.trim()
      ..visitAt = when
      ..completed = existing?.completed ?? false;

    await HealthRepository.instance.saveVisit(visit);
    final upcoming =
        await HealthRepository.instance.upcomingVisits(snap.profile.uuid);
    await NotificationService.rescheduleDoctorVisits(upcoming);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(appControllerProvider).value;
    final s = snap?.strings;

    return Scaffold(
      appBar: AppBar(title: Text(s?.doctorVisits ?? 'Doctor appointments')),
      body: Column(
        children: [
          Expanded(
            child: _visits.isEmpty
                ? Center(child: Text(s?.noVisits ?? 'No appointments yet'))
                : ListView.builder(
                    padding: pagePadding(context, bottom: 16),
                    itemCount: _visits.length,
                    itemBuilder: (context, i) {
                      final v = _visits[i];
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            v.completed
                                ? Icons.check_circle
                                : Icons.event,
                            color: v.completed
                                ? Colors.green
                                : Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(v.doctorName),
                          subtitle: Text(
                            '${DateFormat.yMMMd().add_jm().format(v.visitAt)}'
                            '${v.clinic.isNotEmpty ? '\n${v.clinic}' : ''}',
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (action) async {
                              if (action == 'edit') {
                                await _addOrEdit(existing: v);
                              } else if (action == 'done') {
                                v.completed = true;
                                await HealthRepository.instance.saveVisit(v);
                                await _load();
                              } else if (action == 'delete') {
                                await HealthRepository.instance.deleteVisit(v.id);
                                await _load();
                              }
                            },
                            itemBuilder: (_) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(s?.editProfile ?? 'Edit'),
                              ),
                              if (!v.completed)
                                PopupMenuItem(
                                  value: 'done',
                                  child: Text(
                                    s?.markTaken ?? 'Mark done',
                                  ),
                                ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(s?.deleteProfile ?? 'Delete'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          BottomActionBar(
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _addOrEdit,
                icon: const Icon(Icons.add),
                label: Text(s?.addVisit ?? 'Add appointment'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
