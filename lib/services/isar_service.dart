import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

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

class IsarService {
  IsarService._();

  static Isar? _isar;

  static Isar get isar {
    final db = _isar;
    if (db == null) {
      throw StateError('Isar not initialized. Call IsarService.init() first.');
    }
    return db;
  }

  static Future<void> init() async {
    if (_isar != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        AppSettingsSchema,
        HealthProfileSchema,
        MedicineSchema,
        MedicineDoseLogSchema,
        WaterDayLogSchema,
        VitalsLogSchema,
        EmergencyInfoSchema,
        MoodLogSchema,
        DoctorVisitSchema,
      ],
      directory: dir.path,
      name: 'sehat_saathi',
    );
    await _ensureSettings();
  }

  static Future<AppSettings> _ensureSettings() async {
    final existing = await isar.appSettings.get(0);
    if (existing != null) return existing;

    final settings = AppSettings()
      ..id = 0
      ..language = AppLanguage.en
      ..isDarkMode = false
      ..onboardingComplete = false
      ..waterGoalMl = 2500
      ..isPro = false
      ..waterRemindersEnabled = false
      ..waterReminderTimes = ['09:00', '13:00', '18:00']
      ..snoozeMinutes = 10
      ..appLockEnabled = false
      ..lastMissedAlertDateKey = null
      ..updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.appSettings.put(settings);
    });
    return settings;
  }

  static Future<AppSettings> settings() async {
    await _ensureSettings();
    final s = (await isar.appSettings.get(0))!;
    var patched = false;
    if (s.waterReminderTimes.isEmpty) {
      s.waterReminderTimes = ['09:00', '13:00', '18:00'];
      patched = true;
    }
    if (s.snoozeMinutes <= 0) {
      s.snoozeMinutes = 10;
      patched = true;
    }
    if (patched) await saveSettings(s);
    return s;
  }

  static Future<void> saveSettings(AppSettings settings) async {
    settings.updatedAt = DateTime.now();
    await isar.writeTxn(() async {
      await isar.appSettings.put(settings);
    });
  }
}
