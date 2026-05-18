import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/emergency_info.dart';
import '../../data/repositories/health_repository.dart';
import '../../providers/app_providers.dart';
import '../../widgets/bottom_action_bar.dart';

class EmergencyScreen extends ConsumerStatefulWidget {
  const EmergencyScreen({super.key});

  @override
  ConsumerState<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends ConsumerState<EmergencyScreen> {
  EmergencyInfo? _info;
  late TextEditingController _blood;
  late TextEditingController _contactName;
  late TextEditingController _contactPhone;
  late TextEditingController _allergies;
  late TextEditingController _meds;

  @override
  void initState() {
    super.initState();
    _blood = TextEditingController();
    _contactName = TextEditingController();
    _contactPhone = TextEditingController();
    _allergies = TextEditingController();
    _meds = TextEditingController();
    _load();
  }

  Future<void> _load() async {
    final snap = ref.read(appControllerProvider).value;
    if (snap == null) return;
    final info = await HealthRepository.instance.emergencyFor(snap.profile.uuid);
    if (!mounted || info == null) return;
    setState(() {
      _info = info;
      _blood.text = info.bloodGroup;
      _contactName.text = info.contactName;
      _contactPhone.text = info.contactPhone;
      _allergies.text = info.allergies;
      _meds.text = info.currentMedicines;
    });
  }

  @override
  void dispose() {
    _blood.dispose();
    _contactName.dispose();
    _contactPhone.dispose();
    _allergies.dispose();
    _meds.dispose();
    super.dispose();
  }

  Future<void> _shareCard() async {
    final snap = ref.read(appControllerProvider).value;
    if (snap == null) return;
    final s = snap.strings;
    final profile = snap.profile;

    final buffer = StringBuffer()
      ..writeln('🆘 ${s.emergencyCardSubject}')
      ..writeln('—' * 24)
      ..writeln('${s.isHindi ? 'नाम' : 'Name'}: ${profile.name}')
      ..writeln('${s.isHindi ? 'रक्त समूह' : 'Blood group'}: ${_blood.text.trim().isEmpty ? '—' : _blood.text.trim()}')
      ..writeln('${s.isHindi ? 'संपर्क' : 'Contact'}: ${_contactName.text.trim().isEmpty ? '—' : _contactName.text.trim()}')
      ..writeln('${s.isHindi ? 'फ़ोन' : 'Phone'}: ${_contactPhone.text.trim().isEmpty ? '—' : _contactPhone.text.trim()}')
      ..writeln('${s.isHindi ? 'एलर्जी' : 'Allergies'}: ${_allergies.text.trim().isEmpty ? '—' : _allergies.text.trim()}')
      ..writeln('${s.isHindi ? 'दवाएँ' : 'Medicines'}: ${_meds.text.trim().isEmpty ? '—' : _meds.text.trim()}')
      ..writeln()
      ..writeln(s.notMedicalAdvice);

    await Share.share(buffer.toString(), subject: s.emergencyCardSubject);
  }

  Future<void> _save() async {
    final info = _info;
    if (info == null) return;
    info
      ..bloodGroup = _blood.text.trim()
      ..contactName = _contactName.text.trim()
      ..contactPhone = _contactPhone.text.trim()
      ..allergies = _allergies.text.trim()
      ..currentMedicines = _meds.text.trim();
    await HealthRepository.instance.saveEmergency(info);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final snap = ref.watch(appControllerProvider).value;
    final s = snap?.strings;

    return Scaffold(
      appBar: AppBar(
        title: Text(s?.emergencyInfo ?? 'Emergency info'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              children: [
                if (s?.notMedicalAdvice != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      s!.notMedicalAdvice,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                TextField(
                  controller: _blood,
                  decoration: const InputDecoration(labelText: 'Blood group'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _contactName,
                  decoration:
                      const InputDecoration(labelText: 'Emergency contact name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _contactPhone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Emergency phone'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _allergies,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Allergies'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _meds,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(labelText: 'Current medicines'),
                ),
              ],
            ),
          ),
          BottomActionBar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  onPressed: _shareCard,
                  icon: const Icon(Icons.share_outlined),
                  label: Text(s?.shareEmergencyCard ?? 'Share emergency card'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _save,
                  child: Text(s?.save ?? 'Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
