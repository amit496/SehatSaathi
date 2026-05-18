import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/date_utils.dart';
import '../../services/isar_service.dart';
import '../models/app_settings.dart';
import '../models/doctor_visit.dart';
import '../models/emergency_info.dart';
import '../models/enums.dart';
import '../models/health_profile.dart';
import '../models/medicine.dart';
import '../models/medicine_dose_log.dart';
import '../models/mood_log.dart';
import '../models/vitals_log.dart';
import '../models/water_day_log.dart';

class HealthRepository {
  HealthRepository(this._isar);

  final Isar _isar;
  static const _uuid = Uuid();
  static const freeProfileLimit = 2;

  static HealthRepository get instance => HealthRepository(IsarService.isar);

  Future<AppSettings> getSettings() => IsarService.settings();

  Future<void> updateSettings(AppSettings settings) =>
      IsarService.saveSettings(settings);

  Future<List<HealthProfile>> allProfiles() =>
      _isar.healthProfiles.where().sortByCreatedAt().findAll();

  Future<HealthProfile?> profileByUuid(String? uuid) async {
    if (uuid == null) return null;
    return _isar.healthProfiles.filter().uuidEqualTo(uuid).findFirst();
  }

  Future<HealthProfile?> activeProfile() async {
    final settings = await getSettings();
    var profile = await profileByUuid(settings.activeProfileUuid);
    if (profile != null) return profile;
    final all = await allProfiles();
    return all.isEmpty ? null : all.first;
  }

  Future<HealthProfile> saveProfile({
    HealthProfile? existing,
    required String name,
    required ProfileRelation relation,
    bool isPrimary = false,
  }) async {
    final settings = await getSettings();
    final count = await _isar.healthProfiles.count();
    if (existing == null &&
        !settings.isPro &&
        count >= freeProfileLimit) {
      throw StateError('profile_limit');
    }

    final profile = existing ?? HealthProfile()
      ..uuid = _uuid.v4()
      ..createdAt = DateTime.now();

    profile
      ..name = name.trim()
      ..relation = relation
      ..isPrimary = isPrimary || existing?.isPrimary == true;

    await _isar.writeTxn(() async {
      if (isPrimary) {
        final others = await _isar.healthProfiles.where().findAll();
        for (final p in others) {
          if (p.uuid != profile.uuid) {
            p.isPrimary = false;
            await _isar.healthProfiles.put(p);
          }
        }
      }
      await _isar.healthProfiles.put(profile);
      if (settings.activeProfileUuid == null) {
        settings.activeProfileUuid = profile.uuid;
        await _isar.appSettings.put(settings);
      }
    });

    await _ensureEmergency(profile.uuid);
    return profile;
  }

  Future<void> setActiveProfile(String uuid) async {
    final settings = await getSettings();
    settings.activeProfileUuid = uuid;
    await IsarService.saveSettings(settings);
  }

  Future<void> _ensureEmergency(String profileUuid) async {
    final exists = await _isar.emergencyInfos
        .filter()
        .profileUuidEqualTo(profileUuid)
        .findFirst();
    if (exists != null) return;
    final info = EmergencyInfo()
      ..profileUuid = profileUuid
      ..updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.emergencyInfos.put(info));
  }

  Future<EmergencyInfo?> emergencyFor(String profileUuid) => _isar.emergencyInfos
      .filter()
      .profileUuidEqualTo(profileUuid)
      .findFirst();

  Future<void> saveEmergency(EmergencyInfo info) async {
    info.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.emergencyInfos.put(info));
  }

  Future<List<Medicine>> medicinesFor(String profileUuid) => _isar.medicines
      .filter()
      .profileUuidEqualTo(profileUuid)
      .archivedEqualTo(false)
      .sortByCreatedAtDesc()
      .findAll();

  Future<Medicine> saveMedicine(Medicine medicine) async {
    await _isar.writeTxn(() => _isar.medicines.put(medicine));
    return medicine;
  }

  Future<void> deleteMedicine(int id) async {
    await _isar.writeTxn(() async {
      await _isar.medicines.delete(id);
      await _isar.medicineDoseLogs.filter().medicineIdEqualTo(id).deleteAll();
    });
  }

  Future<List<MedicineDoseLog>> doseLogsForDay(
    String profileUuid,
    String dateKey,
  ) =>
      _isar.medicineDoseLogs
          .filter()
          .profileUuidEqualTo(profileUuid)
          .dateKeyEqualTo(dateKey)
          .findAll();

  Future<MedicineDoseLog> upsertDoseLog({
    required String profileUuid,
    required int medicineId,
    required String dateKey,
    required String scheduledTime,
    required DoseStatus status,
  }) async {
    final existing = await _isar.medicineDoseLogs
        .filter()
        .profileUuidEqualTo(profileUuid)
        .medicineIdEqualTo(medicineId)
        .dateKeyEqualTo(dateKey)
        .scheduledTimeEqualTo(scheduledTime)
        .findFirst();

    final log = existing ?? MedicineDoseLog()
      ..profileUuid = profileUuid
      ..medicineId = medicineId
      ..dateKey = dateKey
      ..scheduledTime = scheduledTime;

    log
      ..status = status
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() => _isar.medicineDoseLogs.put(log));
    return log;
  }

  Future<WaterDayLog> waterForToday(String profileUuid) async {
    final key = DateOnly.key(DateOnly.today());
    final settings = await getSettings();
    final existing = await _isar.waterDayLogs
        .filter()
        .profileUuidEqualTo(profileUuid)
        .dateKeyEqualTo(key)
        .findFirst();

    if (existing != null) return existing;

    final log = WaterDayLog()
      ..profileUuid = profileUuid
      ..dateKey = key
      ..goalMl = settings.waterGoalMl
      ..consumedMl = 0
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() => _isar.waterDayLogs.put(log));
    return log;
  }

  Future<WaterDayLog> addWater(String profileUuid, int ml) async {
    final log = await waterForToday(profileUuid);
    log.consumedMl += ml;
    log.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.waterDayLogs.put(log));
    return log;
  }

  Future<void> setWaterGoal(String profileUuid, int goalMl) async {
    final settings = await getSettings();
    settings.waterGoalMl = goalMl;
    await IsarService.saveSettings(settings);
    final log = await waterForToday(profileUuid);
    log.goalMl = goalMl;
    log.updatedAt = DateTime.now();
    await _isar.writeTxn(() => _isar.waterDayLogs.put(log));
  }

  Future<List<VitalsLog>> vitalsFor(
    String profileUuid,
    VitalsType type, {
    int limit = 30,
  }) =>
      _isar.vitalsLogs
          .filter()
          .profileUuidEqualTo(profileUuid)
          .typeEqualTo(type)
          .sortByRecordedAtDesc()
          .limit(limit)
          .findAll();

  Future<VitalsLog> addVitals(VitalsLog log) async {
    await _isar.writeTxn(() => _isar.vitalsLogs.put(log));
    return log;
  }

  Future<List<MoodLog>> moodsForDay(String profileUuid, String dateKey) =>
      _isar.moodLogs
          .filter()
          .profileUuidEqualTo(profileUuid)
          .dateKeyEqualTo(dateKey)
          .sortByCreatedAtDesc()
          .findAll();

  Future<MoodLog> addMood(MoodLog log) async {
    await _isar.writeTxn(() => _isar.moodLogs.put(log));
    return log;
  }

  Future<List<MoodLog>> moodsForProfile(
    String profileUuid, {
    int limit = 60,
  }) =>
      _isar.moodLogs
          .filter()
          .profileUuidEqualTo(profileUuid)
          .sortByCreatedAtDesc()
          .limit(limit)
          .findAll();

  Future<List<MedicineDoseLog>> doseLogsForProfile(
    String profileUuid, {
    String? dateKey,
    int limit = 200,
  }) async {
    if (dateKey != null) {
      return _isar.medicineDoseLogs
          .filter()
          .profileUuidEqualTo(profileUuid)
          .dateKeyEqualTo(dateKey)
          .sortByUpdatedAtDesc()
          .limit(limit)
          .findAll();
    }
    return _isar.medicineDoseLogs
        .filter()
        .profileUuidEqualTo(profileUuid)
        .sortByUpdatedAtDesc()
        .limit(limit)
        .findAll();
  }

  Future<void> deleteProfile(String uuid) async {
    await _isar.writeTxn(() async {
      final profile = await profileByUuid(uuid);
      if (profile != null) await _isar.healthProfiles.delete(profile.id);

      await _isar.medicines.filter().profileUuidEqualTo(uuid).deleteAll();
      await _isar.medicineDoseLogs.filter().profileUuidEqualTo(uuid).deleteAll();
      await _isar.waterDayLogs.filter().profileUuidEqualTo(uuid).deleteAll();
      await _isar.vitalsLogs.filter().profileUuidEqualTo(uuid).deleteAll();
      await _isar.moodLogs.filter().profileUuidEqualTo(uuid).deleteAll();
      await _isar.emergencyInfos.filter().profileUuidEqualTo(uuid).deleteAll();
      await _isar.doctorVisits.filter().profileUuidEqualTo(uuid).deleteAll();

      final settings = await getSettings();
      if (settings.activeProfileUuid == uuid) {
        final remaining = await allProfiles();
        settings.activeProfileUuid =
            remaining.isEmpty ? null : remaining.first.uuid;
        await _isar.appSettings.put(settings);
      }
    });
  }

  Future<void> decrementRefillOnTaken(int medicineId) async {
    final med = await _isar.medicines.get(medicineId);
    if (med == null || med.refillDaysLeft == null) return;
    if (med.refillDaysLeft! > 0) {
      med.refillDaysLeft = med.refillDaysLeft! - 1;
      await _isar.writeTxn(() => _isar.medicines.put(med));
    }
  }

  List<ScheduledDose> scheduledDosesForToday(List<Medicine> medicines) {
    final today = DateTime.now().weekday;
    final key = DateOnly.key(DateOnly.today());
    final doses = <ScheduledDose>[];

    for (final med in medicines) {
      if (med.archived) continue;
      if (med.repeatDays.isNotEmpty && !med.repeatDays.contains(today)) {
        continue;
      }
      for (final time in med.times) {
        doses.add(ScheduledDose(
          medicine: med,
          dateKey: key,
          scheduledTime: time,
        ));
      }
    }

    doses.sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    return doses;
  }

  List<ScheduledDose> scheduledDosesForDate(
    List<Medicine> medicines,
    DateTime date,
  ) {
    final weekday = date.weekday;
    final key = DateOnly.key(DateOnly.of(date));
    final doses = <ScheduledDose>[];

    for (final med in medicines) {
      if (med.archived) continue;
      if (med.repeatDays.isNotEmpty && !med.repeatDays.contains(weekday)) {
        continue;
      }
      for (final time in med.times) {
        doses.add(ScheduledDose(
          medicine: med,
          dateKey: key,
          scheduledTime: time,
        ));
      }
    }
    doses.sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    return doses;
  }

  Future<List<WaterDayLog>> waterLogsSince(
    String profileUuid,
    String sinceDateKey,
  ) =>
      _isar.waterDayLogs
          .filter()
          .profileUuidEqualTo(profileUuid)
          .dateKeyGreaterThan(sinceDateKey, include: true)
          .findAll();

  Future<List<DoctorVisit>> upcomingVisits(String profileUuid) async {
    final now = DateTime.now();
    return _isar.doctorVisits
        .filter()
        .profileUuidEqualTo(profileUuid)
        .completedEqualTo(false)
        .visitAtGreaterThan(now, include: true)
        .sortByVisitAt()
        .findAll();
  }

  Future<List<DoctorVisit>> allVisits(String profileUuid) => _isar.doctorVisits
      .filter()
      .profileUuidEqualTo(profileUuid)
      .sortByVisitAtDesc()
      .findAll();

  Future<DoctorVisit> saveVisit(DoctorVisit visit) async {
    await _isar.writeTxn(() => _isar.doctorVisits.put(visit));
    return visit;
  }

  Future<void> deleteVisit(int id) async {
    await _isar.writeTxn(() => _isar.doctorVisits.delete(id));
  }
}

class ScheduledDose {
  const ScheduledDose({
    required this.medicine,
    required this.dateKey,
    required this.scheduledTime,
  });

  final Medicine medicine;
  final String dateKey;
  final String scheduledTime;
}
