import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/utils/date_utils.dart';
import '../../data/models/enums.dart';
import '../../data/models/medicine.dart';
import '../../data/models/medicine_dose_log.dart';
import '../../data/repositories/health_repository.dart';
import '../../core/utils/screen_padding.dart';
import '../../providers/app_providers.dart';

class MedicineHistoryScreen extends ConsumerStatefulWidget {
  const MedicineHistoryScreen({super.key, required this.medicine});

  final Medicine medicine;

  @override
  ConsumerState<MedicineHistoryScreen> createState() =>
      _MedicineHistoryScreenState();
}

class _MedicineHistoryScreenState extends ConsumerState<MedicineHistoryScreen> {
  DateTime _focused = DateTime.now();
  DateTime _selected = DateTime.now();
  List<MedicineDoseLog> _logs = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final key = DateOnly.key(DateOnly.of(_selected));
    final logs = await HealthRepository.instance.doseLogsForProfile(
      widget.medicine.profileUuid,
      dateKey: key,
    );
    if (!mounted) return;
    setState(() {
      _logs = logs
          .where((l) => l.medicineId == widget.medicine.id)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appControllerProvider).value?.strings;

    return Scaffold(
      appBar: AppBar(
        title: Text(s?.medicineHistory ?? 'Medicine history'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 30)),
            focusedDay: _focused,
            selectedDayPredicate: (d) => DateOnly.of(d) == DateOnly.of(_selected),
            onDaySelected: (selected, focused) {
              setState(() {
                _selected = selected;
                _focused = focused;
              });
              _load();
            },
            calendarStyle: const CalendarStyle(
              markersMaxCount: 1,
            ),
          ),
          Expanded(
            child: ListView(
              padding: pagePadding(context, bottom: 16),
              children: [
                Text(
                  '${_selected.day}/${_selected.month}/${_selected.year}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (_logs.isEmpty)
                  Text(s?.isHindi == true ? 'कोई लॉग नहीं' : 'No logs')
                else
                  ..._logs.map(
                    (l) => ListTile(
                      leading: Icon(
                        l.status == DoseStatus.taken
                            ? Icons.check_circle
                            : l.status == DoseStatus.skipped
                                ? Icons.remove_circle_outline
                                : Icons.schedule,
                      ),
                      title: Text(l.scheduledTime),
                      subtitle: Text(l.status.name),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  s?.isHindi == true
                      ? 'निर्धारित: ${HealthRepository.instance.scheduledDosesForDate([widget.medicine], _selected).map((d) => d.scheduledTime).join(', ')}'
                      : 'Scheduled: ${HealthRepository.instance.scheduledDosesForDate([widget.medicine], _selected).map((d) => d.scheduledTime).join(', ')}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
