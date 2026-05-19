import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants/meal_timing_labels.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/weekday_labels.dart';
import '../../core/l10n/app_strings.dart';
import '../../data/models/enums.dart';
import '../../data/models/medicine.dart';
import '../../providers/app_providers.dart';
import '../../widgets/bottom_action_bar.dart';

class MedicineFormScreen extends ConsumerStatefulWidget {
  const MedicineFormScreen({
    super.key,
    required this.profileUuid,
    this.medicine,
  });

  final String profileUuid;
  final Medicine? medicine;

  @override
  ConsumerState<MedicineFormScreen> createState() => _MedicineFormScreenState();
}

class _MedicineFormScreenState extends ConsumerState<MedicineFormScreen> {
  late final TextEditingController _name;
  late final TextEditingController _dose;
  late final TextEditingController _mealNote;
  late final TextEditingController _refillDays;
  late MealTiming _mealTiming;
  late List<String> _times;
  late List<int> _days;
  late bool _refillAlert;
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    final m = widget.medicine;
    _name = TextEditingController(text: m?.name ?? '');
    _dose = TextEditingController(text: m?.dose ?? '1 tablet');
    _mealNote = TextEditingController(text: m?.mealNote ?? '');
    _refillDays = TextEditingController(
      text: m?.refillDaysLeft?.toString() ?? '',
    );
    _mealTiming = m?.mealTiming ?? MealTiming.anyTime;
    _times = List.from(m?.times ?? ['08:00', '20:00']);
    _days = List.from(m?.repeatDays ?? [1, 2, 3, 4, 5, 6, 7]);
    _refillAlert = m?.refillAlertEnabled ?? false;
    _photoPath = m?.photoPath;
  }

  @override
  void dispose() {
    _name.dispose();
    _dose.dispose();
    _mealNote.dispose();
    _refillDays.dispose();
    super.dispose();
  }

  AppStrings get _s {
    final lang = ref.read(appControllerProvider).value?.settings.language ??
        AppLanguage.en;
    return AppStrings.of(lang);
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (file == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final name = 'med_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final saved = await File(file.path).copy('${dir.path}/$name');
    setState(() => _photoPath = saved.path);
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;

    final med = widget.medicine ?? Medicine()
      ..profileUuid = widget.profileUuid
      ..createdAt = DateTime.now()
      ..archived = false;

    med
      ..name = _name.text.trim()
      ..dose = _dose.text.trim()
      ..mealNote = _mealNote.text.trim()
      ..mealTiming = _mealTiming
      ..times = _times
      ..repeatDays = _days
      ..photoPath = _photoPath
      ..refillAlertEnabled = _refillAlert
      ..refillDaysLeft = int.tryParse(_refillDays.text.trim());

    await ref.read(appControllerProvider.notifier).saveMedicine(med);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final m = widget.medicine;
    if (m == null) return;
    await ref.read(appControllerProvider.notifier).deleteMedicine(m.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final s = _s;

    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      appBar: AppBar(
        title: Text(
          widget.medicine == null ? s.addMedicine : s.editMedicine,
        ),
        actions: [
          if (widget.medicine != null)
            IconButton(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        children: [
          Center(
            child: GestureDetector(
              onTap: _pickPhoto,
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                backgroundImage:
                    _photoPath != null ? FileImage(File(_photoPath!)) : null,
                child: _photoPath == null
                    ? const Icon(Icons.add_a_photo, size: 32)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _name,
            decoration: InputDecoration(
              labelText: s.isHindi ? 'दवा का नाम' : 'Medicine name',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dose,
            decoration: InputDecoration(
              labelText: s.isHindi ? 'खुराक' : 'Dose',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _mealNote,
            decoration: InputDecoration(
              labelText: s.isHindi ? 'भोजन नोट' : 'Meal note',
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<MealTiming>(
            initialValue: _mealTiming,
            decoration: InputDecoration(
              labelText: s.isHindi ? 'भोजन समय' : 'Meal timing',
            ),
            items: MealTiming.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(MealTimingLabels.label(e, s)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => _mealTiming = v ?? _mealTiming),
          ),
          const SizedBox(height: 16),
          Text(
            s.isHindi ? 'दोहराएँ' : 'Repeat on',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: WeekdayLabels.weekdays.map((d) {
              final selected = _days.contains(d);
              return FilterChip(
                label: Text(WeekdayLabels.short(d, s)),
                selected: selected,
                onSelected: (v) {
                  setState(() {
                    if (v) {
                      _days.add(d);
                    } else {
                      _days.remove(d);
                    }
                    _days.sort();
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(s.isHindi ? 'समय' : 'Times',
              style: Theme.of(context).textTheme.titleMedium),
          ..._times.asMap().entries.map(
            (e) => ListTile(
              title: Text(e.value),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _times.removeAt(e.key)),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time == null) return;
              setState(() {
                _times.add(
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                );
              });
            },
            icon: const Icon(Icons.add),
            label: Text(s.isHindi ? 'समय जोड़ें' : 'Add time'),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text(s.refillReminder),
            subtitle: Text(s.refillReminderHint),
            value: _refillAlert,
            onChanged: (v) => setState(() => _refillAlert = v),
          ),
          if (_refillAlert) ...[
            TextField(
              controller: _refillDays,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: s.isHindi ? 'बचे दिन' : 'Days of supply left',
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
            ),
          ),
          BottomActionBar(
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: Text(s.isHindi ? 'सहेजें' : 'Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
