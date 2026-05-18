import 'dart:convert';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:share_plus/share_plus.dart';

import '../data/models/app_settings.dart';
import '../data/models/doctor_visit.dart';
import '../data/models/emergency_info.dart';
import '../data/models/enums.dart';
import '../data/models/health_profile.dart';
import '../data/models/medicine.dart';
import '../data/models/medicine_dose_log.dart';
import '../data/models/mood_log.dart';
import '../data/models/vitals_log.dart';
import '../data/models/water_day_log.dart';
import 'isar_service.dart';

class BackupService {
  BackupService(this._isar);

  final Isar _isar;
  static const version = 1;

  static BackupService get instance => BackupService(IsarService.isar);

  Future<String> exportJson() async {
    final data = await _collect();
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  Future<void> shareBackup() async {
    final json = await exportJson();
    await Share.share(json, subject: 'SehatSaathi backup');
  }

  Future<void> restoreFromJson(String raw) async {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    if (map['version'] != version) {
      throw FormatException('Unsupported backup version');
    }

    await _isar.writeTxn(() async {
      await _isar.clear();
    });

    final settings = _settingsFromJson(map['settings'] as Map<String, dynamic>);
    await _isar.writeTxn(() async {
      await _isar.appSettings.put(settings);
      for (final p in map['profiles'] as List) {
        await _isar.healthProfiles.put(_profileFromJson(p as Map<String, dynamic>));
      }
      for (final m in map['medicines'] as List) {
        await _isar.medicines.put(_medicineFromJson(m as Map<String, dynamic>));
      }
      for (final l in map['doseLogs'] as List) {
        await _isar.medicineDoseLogs.put(_doseLogFromJson(l as Map<String, dynamic>));
      }
      for (final w in map['waterLogs'] as List) {
        await _isar.waterDayLogs.put(_waterFromJson(w as Map<String, dynamic>));
      }
      for (final v in map['vitals'] as List) {
        await _isar.vitalsLogs.put(_vitalsFromJson(v as Map<String, dynamic>));
      }
      for (final e in map['emergency'] as List) {
        await _isar.emergencyInfos.put(_emergencyFromJson(e as Map<String, dynamic>));
      }
      for (final m in map['moods'] as List) {
        await _isar.moodLogs.put(_moodFromJson(m as Map<String, dynamic>));
      }
      for (final v in map['doctorVisits'] as List? ?? []) {
        await _isar.doctorVisits.put(_visitFromJson(v as Map<String, dynamic>));
      }
    });
  }

  Future<Map<String, dynamic>> _collect() async {
    final settings = await IsarService.settings();
    final profiles = await _isar.healthProfiles.where().findAll();
    final medicines = await _isar.medicines.where().findAll();
    final doseLogs = await _isar.medicineDoseLogs.where().findAll();
    final waterLogs = await _isar.waterDayLogs.where().findAll();
    final vitals = await _isar.vitalsLogs.where().findAll();
    final emergency = await _isar.emergencyInfos.where().findAll();
    final moods = await _isar.moodLogs.where().findAll();
    final visits = await _isar.doctorVisits.where().findAll();

    return {
      'version': version,
      'exportedAt': DateTime.now().toIso8601String(),
      'settings': _settingsToJson(settings),
      'profiles': profiles.map(_profileToJson).toList(),
      'medicines': medicines.map(_medicineToJson).toList(),
      'doseLogs': doseLogs.map(_doseLogToJson).toList(),
      'waterLogs': waterLogs.map(_waterToJson).toList(),
      'vitals': vitals.map(_vitalsToJson).toList(),
      'emergency': emergency.map(_emergencyToJson).toList(),
      'moods': moods.map(_moodToJson).toList(),
      'doctorVisits': visits.map(_visitToJson).toList(),
    };
  }

  Map<String, dynamic> _settingsToJson(AppSettings s) => {
        'language': s.language.name,
        'isDarkMode': s.isDarkMode,
        'onboardingComplete': s.onboardingComplete,
        'activeProfileUuid': s.activeProfileUuid,
        'waterGoalMl': s.waterGoalMl,
        'isPro': s.isPro,
        'waterRemindersEnabled': s.waterRemindersEnabled,
        'waterReminderTimes': s.waterReminderTimes,
        'snoozeMinutes': s.snoozeMinutes,
        'appLockEnabled': s.appLockEnabled,
        'pinHash': s.pinHash,
        'lastMissedAlertDateKey': s.lastMissedAlertDateKey,
      };

  AppSettings _settingsFromJson(Map<String, dynamic> j) => AppSettings()
    ..id = 0
    ..language = AppLanguage.values.byName(j['language'] as String)
    ..isDarkMode = j['isDarkMode'] as bool
    ..onboardingComplete = j['onboardingComplete'] as bool
    ..activeProfileUuid = j['activeProfileUuid'] as String?
    ..waterGoalMl = j['waterGoalMl'] as int
    ..isPro = j['isPro'] as bool? ?? false
    ..waterRemindersEnabled = j['waterRemindersEnabled'] as bool? ?? false
    ..waterReminderTimes =
        List<String>.from(j['waterReminderTimes'] as List? ?? ['09:00', '13:00', '18:00'])
    ..snoozeMinutes = j['snoozeMinutes'] as int? ?? 10
    ..appLockEnabled = j['appLockEnabled'] as bool? ?? false
    ..pinHash = j['pinHash'] as String?
    ..lastMissedAlertDateKey = j['lastMissedAlertDateKey'] as String?
    ..updatedAt = DateTime.now();

  Map<String, dynamic> _profileToJson(HealthProfile p) => {
        'id': p.id,
        'uuid': p.uuid,
        'name': p.name,
        'relation': p.relation.name,
        'avatarPath': p.avatarPath,
        'isPrimary': p.isPrimary,
        'createdAt': p.createdAt.toIso8601String(),
      };

  HealthProfile _profileFromJson(Map<String, dynamic> j) => HealthProfile()
    ..id = j['id'] as int
    ..uuid = j['uuid'] as String
    ..name = j['name'] as String
    ..relation = ProfileRelation.values.byName(j['relation'] as String)
    ..avatarPath = j['avatarPath'] as String?
    ..isPrimary = j['isPrimary'] as bool
    ..createdAt = DateTime.parse(j['createdAt'] as String);

  Map<String, dynamic> _medicineToJson(Medicine m) => {
        'id': m.id,
        'profileUuid': m.profileUuid,
        'name': m.name,
        'dose': m.dose,
        'photoPath': m.photoPath,
        'times': m.times,
        'repeatDays': m.repeatDays,
        'mealTiming': m.mealTiming.name,
        'mealNote': m.mealNote,
        'refillDaysLeft': m.refillDaysLeft,
        'refillAlertEnabled': m.refillAlertEnabled,
        'archived': m.archived,
        'createdAt': m.createdAt.toIso8601String(),
      };

  Medicine _medicineFromJson(Map<String, dynamic> j) => Medicine()
    ..id = j['id'] as int
    ..profileUuid = j['profileUuid'] as String
    ..name = j['name'] as String
    ..dose = j['dose'] as String
    ..photoPath = j['photoPath'] as String?
    ..times = List<String>.from(j['times'] as List)
    ..repeatDays = List<int>.from(j['repeatDays'] as List)
    ..mealTiming = MealTiming.values.byName(j['mealTiming'] as String)
    ..mealNote = j['mealNote'] as String? ?? ''
    ..refillDaysLeft = j['refillDaysLeft'] as int?
    ..refillAlertEnabled = j['refillAlertEnabled'] as bool
    ..archived = j['archived'] as bool
    ..createdAt = DateTime.parse(j['createdAt'] as String);

  Map<String, dynamic> _doseLogToJson(MedicineDoseLog l) => {
        'id': l.id,
        'profileUuid': l.profileUuid,
        'medicineId': l.medicineId,
        'dateKey': l.dateKey,
        'scheduledTime': l.scheduledTime,
        'status': l.status.name,
        'updatedAt': l.updatedAt.toIso8601String(),
      };

  MedicineDoseLog _doseLogFromJson(Map<String, dynamic> j) => MedicineDoseLog()
    ..id = j['id'] as int
    ..profileUuid = j['profileUuid'] as String
    ..medicineId = j['medicineId'] as int
    ..dateKey = j['dateKey'] as String
    ..scheduledTime = j['scheduledTime'] as String
    ..status = DoseStatus.values.byName(j['status'] as String)
    ..updatedAt = DateTime.parse(j['updatedAt'] as String);

  Map<String, dynamic> _waterToJson(WaterDayLog w) => {
        'id': w.id,
        'profileUuid': w.profileUuid,
        'dateKey': w.dateKey,
        'goalMl': w.goalMl,
        'consumedMl': w.consumedMl,
        'updatedAt': w.updatedAt.toIso8601String(),
      };

  WaterDayLog _waterFromJson(Map<String, dynamic> j) => WaterDayLog()
    ..id = j['id'] as int
    ..profileUuid = j['profileUuid'] as String
    ..dateKey = j['dateKey'] as String
    ..goalMl = j['goalMl'] as int
    ..consumedMl = j['consumedMl'] as int
    ..updatedAt = DateTime.parse(j['updatedAt'] as String);

  Map<String, dynamic> _vitalsToJson(VitalsLog v) => {
        'id': v.id,
        'profileUuid': v.profileUuid,
        'type': v.type.name,
        'systolic': v.systolic,
        'diastolic': v.diastolic,
        'sugarMgDl': v.sugarMgDl,
        'note': v.note,
        'recordedAt': v.recordedAt.toIso8601String(),
      };

  VitalsLog _vitalsFromJson(Map<String, dynamic> j) => VitalsLog()
    ..id = j['id'] as int
    ..profileUuid = j['profileUuid'] as String
    ..type = VitalsType.values.byName(j['type'] as String)
    ..systolic = j['systolic'] as int?
    ..diastolic = j['diastolic'] as int?
    ..sugarMgDl = (j['sugarMgDl'] as num?)?.toDouble()
    ..note = j['note'] as String? ?? ''
    ..recordedAt = DateTime.parse(j['recordedAt'] as String);

  Map<String, dynamic> _emergencyToJson(EmergencyInfo e) => {
        'id': e.id,
        'profileUuid': e.profileUuid,
        'bloodGroup': e.bloodGroup,
        'contactName': e.contactName,
        'contactPhone': e.contactPhone,
        'allergies': e.allergies,
        'currentMedicines': e.currentMedicines,
        'updatedAt': e.updatedAt.toIso8601String(),
      };

  EmergencyInfo _emergencyFromJson(Map<String, dynamic> j) => EmergencyInfo()
    ..id = j['id'] as int
    ..profileUuid = j['profileUuid'] as String
    ..bloodGroup = j['bloodGroup'] as String? ?? ''
    ..contactName = j['contactName'] as String? ?? ''
    ..contactPhone = j['contactPhone'] as String? ?? ''
    ..allergies = j['allergies'] as String? ?? ''
    ..currentMedicines = j['currentMedicines'] as String? ?? ''
    ..updatedAt = DateTime.parse(j['updatedAt'] as String);

  Map<String, dynamic> _moodToJson(MoodLog m) => {
        'id': m.id,
        'profileUuid': m.profileUuid,
        'dateKey': m.dateKey,
        'mood': m.mood.name,
        'note': m.note,
        'createdAt': m.createdAt.toIso8601String(),
      };

  MoodLog _moodFromJson(Map<String, dynamic> j) => MoodLog()
    ..id = j['id'] as int
    ..profileUuid = j['profileUuid'] as String
    ..dateKey = j['dateKey'] as String
    ..mood = MoodLevel.values.byName(j['mood'] as String)
    ..note = j['note'] as String? ?? ''
    ..createdAt = DateTime.parse(j['createdAt'] as String);

  Map<String, dynamic> _visitToJson(DoctorVisit v) => {
        'id': v.id,
        'profileUuid': v.profileUuid,
        'doctorName': v.doctorName,
        'clinic': v.clinic,
        'notes': v.notes,
        'visitAt': v.visitAt.toIso8601String(),
        'completed': v.completed,
      };

  DoctorVisit _visitFromJson(Map<String, dynamic> j) => DoctorVisit()
    ..id = j['id'] as int
    ..profileUuid = j['profileUuid'] as String
    ..doctorName = j['doctorName'] as String
    ..clinic = j['clinic'] as String? ?? ''
    ..notes = j['notes'] as String? ?? ''
    ..visitAt = DateTime.parse(j['visitAt'] as String)
    ..completed = j['completed'] as bool? ?? false;

  Future<void> restoreFromFile(String path) async {
    final raw = await File(path).readAsString();
    await restoreFromJson(raw);
  }
}
