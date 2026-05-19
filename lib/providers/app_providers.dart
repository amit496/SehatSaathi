import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/l10n/app_strings.dart';
import '../core/utils/date_utils.dart';
import '../core/utils/dose_schedule_utils.dart';
import '../core/utils/health_score.dart';
import '../services/notification_service.dart';
import '../data/models/app_settings.dart';
import '../data/models/enums.dart';
import '../data/models/health_profile.dart';
import '../data/models/medicine.dart';
import '../data/models/medicine_dose_log.dart';
import '../data/models/water_day_log.dart';
import '../data/repositories/health_repository.dart';
import '../services/backup_service.dart';
import '../services/export_service.dart';
import '../services/isar_service.dart';

final repositoryProvider = Provider<HealthRepository>(
  (ref) => HealthRepository.instance,
);

final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService.instance,
);

final exportServiceProvider = Provider<ExportService>(
  (ref) => ExportService(ref.watch(repositoryProvider)),
);

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.settings,
    required this.profile,
    required this.medicines,
    required this.scheduledDoses,
    required this.doseLogs,
    required this.water,
    required this.healthScore,
    required this.missedDoses,
  });

  final AppSettings settings;
  final HealthProfile profile;
  final List<Medicine> medicines;
  final List<ScheduledDose> scheduledDoses;
  final List<MedicineDoseLog> doseLogs;
  final WaterDayLog water;
  final int healthScore;
  final List<ScheduledDose> missedDoses;

  AppStrings get strings => AppStrings.of(settings.language);
}

class AppController extends StateNotifier<AsyncValue<DashboardSnapshot?>> {
  AppController(this._repo, this._backup) : super(const AsyncValue.loading()) {
    refresh();
  }

  final HealthRepository _repo;
  final BackupService _backup;

  AppSettings? _cachedSettings;
  List<HealthProfile> _profiles = [];

  AppSettings? get settings => _cachedSettings;
  List<HealthProfile> get profiles => _profiles;

  Future<void> _rescheduleNotifications() async {
    final settings = await _repo.getSettings();
    final snap = state.value;
    if (snap == null) return;
    await NotificationService.rescheduleAll(
      medicines: snap.medicines,
      settings: settings,
    );
  }

  Future<void> refresh() async {
    try {
      final settings = await _repo.getSettings();
      _cachedSettings = settings;
      _profiles = await _repo.allProfiles();

      if (!settings.onboardingComplete || _profiles.isEmpty) {
        state = const AsyncValue.data(null);
        return;
      }

      final profile = await _repo.activeProfile();
      if (profile == null) {
        state = const AsyncValue.data(null);
        return;
      }

      final medicines = await _repo.medicinesFor(profile.uuid);
      final scheduled = _repo.scheduledDosesForToday(medicines);
      final dateKey = DateOnly.key(DateOnly.today());
      final doseLogs = await _repo.doseLogsForDay(profile.uuid, dateKey);
      final water = await _repo.waterForToday(profile.uuid);
      final score = HealthScoreCalculator.dailyScore(
        scheduled: scheduled,
        logs: doseLogs,
        waterConsumed: water.consumedMl,
        waterGoal: water.goalMl,
      );
      final missed = DoseScheduleUtils.missedDoses(scheduled, doseLogs);

      final snapshot = DashboardSnapshot(
        settings: settings,
        profile: profile,
        medicines: medicines,
        scheduledDoses: scheduled,
        doseLogs: doseLogs,
        water: water,
        healthScore: score,
        missedDoses: missed,
      );

      state = AsyncValue.data(snapshot);

      unawaited(_syncNotifications(
        medicines: medicines,
        settings: settings,
        missed: missed,
        profileUuid: profile.uuid,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> _syncNotifications({
    required List<Medicine> medicines,
    required AppSettings settings,
    required List<ScheduledDose> missed,
    required String profileUuid,
  }) async {
    try {
      await NotificationService.rescheduleAll(
        medicines: medicines,
        settings: settings,
      );
      await NotificationService.maybeAlertMissedDoses(
        missed: missed,
        settings: settings,
        isHindi: settings.language == AppLanguage.hi,
      );
      await NotificationService.rescheduleDoctorVisits(
        await _repo.upcomingVisits(profileUuid),
      );
    } catch (_) {
      // Notifications must not block the home screen.
    }
  }

  Future<void> handleNotificationAction(
    String actionId,
    String? payload,
  ) async {
    final parsed = NotificationService.parsePayload(payload);
    if (parsed == null) return;

    final snap = state.value;
    if (snap == null) return;

    final dateKey = DateOnly.key(DateOnly.today());
    if (actionId == 'snooze') {
      final settings = await _repo.getSettings();
      await NotificationService.snoozeMedicine(
        payload: payload!,
        minutes: settings.snoozeMinutes,
      );
      return;
    }

    if (actionId == 'taken' || actionId == 'tap') {
      await _repo.upsertDoseLog(
        profileUuid: parsed.profileUuid,
        medicineId: parsed.medicineId,
        dateKey: dateKey,
        scheduledTime: parsed.time,
        status: DoseStatus.taken,
      );
      await _repo.decrementRefillOnTaken(parsed.medicineId);
    } else if (actionId == 'skipped') {
      await _repo.upsertDoseLog(
        profileUuid: parsed.profileUuid,
        medicineId: parsed.medicineId,
        dateKey: dateKey,
        scheduledTime: parsed.time,
        status: DoseStatus.skipped,
      );
    }
    await refresh();
  }

  Future<void> snoozeDose(ScheduledDose dose) async {
    final settings = await _repo.getSettings();
    final payload = NotificationService.medicinePayload(
      medicineId: dose.medicine.id,
      time: dose.scheduledTime,
      profileUuid: dose.medicine.profileUuid,
    );
    await NotificationService.snoozeMedicine(
      payload: payload,
      minutes: settings.snoozeMinutes,
    );
  }

  Future<void> completeOnboarding({
    required AppLanguage language,
    required String name,
    required ProfileRelation relation,
    bool enableWaterReminders = false,
  }) async {
    final settings = await _repo.getSettings();
    settings.language = language;
    settings.onboardingComplete = true;
    settings.waterRemindersEnabled = enableWaterReminders;
    await _repo.updateSettings(settings);
    await _repo.saveProfile(
      name: name,
      relation: relation,
      isPrimary: true,
    );
    await refresh();
  }

  Future<void> setLanguage(AppLanguage language) async {
    final settings = await _repo.getSettings();
    settings.language = language;
    await _repo.updateSettings(settings);
    await refresh();
  }

  Future<void> toggleTheme() async {
    final settings = await _repo.getSettings();
    settings.isDarkMode = !settings.isDarkMode;
    await _repo.updateSettings(settings);
    await refresh();
  }

  Future<void> setWaterReminders({
    required bool enabled,
    List<String>? times,
  }) async {
    final settings = await _repo.getSettings();
    settings.waterRemindersEnabled = enabled;
    if (times != null) settings.waterReminderTimes = times;
    await _repo.updateSettings(settings);
    await NotificationService.rescheduleWaterReminders(settings);
    await refresh();
  }

  Future<void> setActiveProfile(String uuid) async {
    await _repo.setActiveProfile(uuid);
    await refresh();
  }

  Future<void> saveProfile({
    HealthProfile? existing,
    required String name,
    required ProfileRelation relation,
  }) async {
    await _repo.saveProfile(
      existing: existing,
      name: name,
      relation: relation,
    );
    await refresh();
  }

  Future<void> deleteProfile(String uuid) async {
    await _repo.deleteProfile(uuid);
    await refresh();
  }

  Future<void> updateDoseStatus(
    ScheduledDose dose,
    DoseStatus status,
  ) async {
    final snap = state.value;
    if (snap == null) return;
    await _repo.upsertDoseLog(
      profileUuid: snap.profile.uuid,
      medicineId: dose.medicine.id,
      dateKey: dose.dateKey,
      scheduledTime: dose.scheduledTime,
      status: status,
    );
    if (status == DoseStatus.taken) {
      await _repo.decrementRefillOnTaken(dose.medicine.id);
    }
    await refresh();
  }

  Future<void> addWater(int ml) async {
    final snap = state.value;
    if (snap == null) return;
    await _repo.addWater(snap.profile.uuid, ml);
    await refresh();
  }

  Future<void> setWaterGoal(int ml) async {
    final snap = state.value;
    if (snap == null) return;
    await _repo.setWaterGoal(snap.profile.uuid, ml);
    await refresh();
  }

  Future<Medicine> saveMedicine(Medicine medicine) async {
    final saved = await _repo.saveMedicine(medicine);
    await _rescheduleNotifications();
    await refresh();
    return saved;
  }

  Future<void> deleteMedicine(int id) async {
    await _repo.deleteMedicine(id);
    await _rescheduleNotifications();
    await refresh();
  }

  Future<void> exportBackup() => _backup.shareBackup();

  Future<void> restoreBackup(String raw) async {
    await _backup.restoreFromJson(raw);
    await refresh();
  }

  Future<void> resetOnboarding() async {
    final settings = await _repo.getSettings();
    settings.onboardingComplete = false;
    await _repo.updateSettings(settings);
    await refresh();
  }
}

final appControllerProvider =
    StateNotifierProvider<AppController, AsyncValue<DashboardSnapshot?>>(
  (ref) => AppController(
    ref.watch(repositoryProvider),
    ref.watch(backupServiceProvider),
  ),
);

Future<void> bootstrapApp() async {
  await IsarService.init();
  await NotificationService.init();
  NotificationService.setActionHandler((action, payload) async {
    // Handler wired from ProviderScope in main after first frame.
  });
}
