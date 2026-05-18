import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../data/models/app_settings.dart';
import '../data/models/doctor_visit.dart';
import '../data/models/medicine.dart';
import '../data/repositories/health_repository.dart';
import '../core/utils/date_utils.dart';
import 'isar_service.dart';

typedef NotificationActionHandler = Future<void> Function(
  String actionId,
  String? payload,
);

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _ready = false;
  static NotificationActionHandler? _handler;

  static const _medicineBaseId = 3000;
  static const _waterBaseId = 2900;
  static const _refillBaseId = 2800;
  static const _snoozeBaseId = 2700;
  static const _missedId = 2600;
  static const _visitBaseId = 2500;

  static bool get isReady => _ready;

  static void setActionHandler(NotificationActionHandler handler) {
    _handler = handler;
  }

  static Future<void> init() async {
    if (_ready) return;
    try {
      tz_data.initializeTimeZones();
      try {
        final name = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(name));
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('UTC'));
      }

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      await _plugin.initialize(
        const InitializationSettings(
          android: android,
          iOS: DarwinInitializationSettings(),
        ),
        onDidReceiveNotificationResponse: _onResponse,
        onDidReceiveBackgroundNotificationResponse: _onBackgroundResponse,
      );

      if (Platform.isAndroid) {
        final androidImpl = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        await androidImpl?.createNotificationChannel(
          const AndroidNotificationChannel(
            'sehat_medicine',
            'Medicine reminders',
            description: 'Medicine dose reminders',
            importance: Importance.high,
          ),
        );
        await androidImpl?.createNotificationChannel(
          const AndroidNotificationChannel(
            'sehat_water',
            'Water reminders',
            description: 'Hydration reminders',
            importance: Importance.defaultImportance,
          ),
        );
        await androidImpl?.createNotificationChannel(
          const AndroidNotificationChannel(
            'sehat_refill',
            'Refill reminders',
            description: 'Medicine refill alerts',
            importance: Importance.high,
          ),
        );
        await androidImpl?.createNotificationChannel(
          const AndroidNotificationChannel(
            'sehat_visit',
            'Doctor visits',
            description: 'Appointment reminders',
            importance: Importance.high,
          ),
        );
        await androidImpl?.requestNotificationsPermission();
        await androidImpl?.requestExactAlarmsPermission();
      }

      _ready = true;
    } on MissingPluginException catch (e) {
      debugPrint('NotificationService: $e');
      _ready = false;
    } catch (e) {
      debugPrint('NotificationService init failed: $e');
      _ready = false;
    }
  }

  static void _onResponse(NotificationResponse response) {
    _handler?.call(response.actionId ?? 'tap', response.payload);
  }

  @pragma('vm:entry-point')
  static void _onBackgroundResponse(NotificationResponse response) {
    _handler?.call(response.actionId ?? 'tap', response.payload);
  }

  static String medicinePayload({
    required int medicineId,
    required String time,
    required String profileUuid,
  }) =>
      'med|$medicineId|$time|$profileUuid';

  static ({int medicineId, String time, String profileUuid})? parsePayload(
    String? payload,
  ) {
    if (payload == null || !payload.startsWith('med|')) return null;
    final parts = payload.split('|');
    if (parts.length < 4) return null;
    final id = int.tryParse(parts[1]);
    if (id == null) return null;
    return (
      medicineId: id,
      time: parts[2],
      profileUuid: parts[3],
    );
  }

  static NotificationDetails _medicineDetails(String payload) =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          'sehat_medicine',
          'Medicine reminders',
          importance: Importance.high,
          priority: Priority.high,
          category: AndroidNotificationCategory.reminder,
          actions: const [
            AndroidNotificationAction(
              'taken',
              'Taken',
              showsUserInterface: true,
            ),
            AndroidNotificationAction(
              'snooze',
              'Snooze',
              showsUserInterface: false,
            ),
            AndroidNotificationAction(
              'skipped',
              'Skip',
              showsUserInterface: true,
            ),
          ],
        ),
        iOS: const DarwinNotificationDetails(
          categoryIdentifier: 'medicine',
        ),
      );

  static Future<void> _cancelRange(int start, int end) async {
    for (var id = start; id < end; id++) {
      await _plugin.cancel(id);
    }
  }

  static Future<void> rescheduleMedicines(List<Medicine> medicines) async {
    if (!_ready) return;
    await _cancelRange(_medicineBaseId, _medicineBaseId + 500);

    var offset = 0;
    for (final med in medicines) {
      if (med.archived) continue;
      final today = DateTime.now().weekday;
      if (med.repeatDays.isNotEmpty && !med.repeatDays.contains(today)) {
        continue;
      }
      for (var i = 0; i < med.times.length; i++) {
        final parts = med.times[i].split(':');
        if (parts.length != 2) continue;
        final hour = int.tryParse(parts[0]);
        final minute = int.tryParse(parts[1]);
        if (hour == null || minute == null) continue;

        final now = tz.TZDateTime.now(tz.local);
        var scheduled = tz.TZDateTime(
          tz.local,
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );
        if (scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 1));
        }

        final payload = medicinePayload(
          medicineId: med.id,
          time: med.times[i],
          profileUuid: med.profileUuid,
        );

        await _plugin.zonedSchedule(
          _medicineBaseId + offset,
          'SehatSaathi',
          '${med.name} — ${med.dose}',
          scheduled,
          _medicineDetails(payload),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: payload,
        );
        offset++;
      }
    }
  }

  static Future<void> rescheduleWaterReminders(AppSettings settings) async {
    if (!_ready) return;
    await _cancelRange(_waterBaseId, _waterBaseId + 20);

    if (!settings.waterRemindersEnabled) return;

    var offset = 0;
    for (final time in settings.waterReminderTimes) {
      final parts = time.split(':');
      if (parts.length != 2) continue;
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour == null || minute == null) continue;

      final now = tz.TZDateTime.now(tz.local);
      var scheduled = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );
      if (scheduled.isBefore(now)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }

      await _plugin.zonedSchedule(
        _waterBaseId + offset,
        'SehatSaathi',
        'Time to drink water 💧',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'sehat_water',
            'Water reminders',
            importance: Importance.defaultImportance,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      offset++;
    }
  }

  static Future<void> rescheduleRefillAlerts(List<Medicine> medicines) async {
    if (!_ready) return;
    await _cancelRange(_refillBaseId, _refillBaseId + 100);

    var offset = 0;
    for (final med in medicines) {
      if (med.archived || !med.refillAlertEnabled) continue;
      final days = med.refillDaysLeft;
      if (days == null || days > 5) continue;

      final now = tz.TZDateTime.now(tz.local);
      var scheduled = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        9,
        0,
      );
      if (scheduled.isBefore(now)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }

      await _plugin.zonedSchedule(
        _refillBaseId + offset,
        'SehatSaathi — Refill',
        days <= 0
            ? '${med.name} may need a refill today'
            : '${med.name}: $days day(s) of supply left',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'sehat_refill',
            'Refill reminders',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      offset++;
    }
  }

  static Future<void> snoozeMedicine({
    required String payload,
    required int minutes,
  }) async {
    if (!_ready) return;
    final parsed = parsePayload(payload);
    if (parsed == null) return;

    final now = tz.TZDateTime.now(tz.local).add(Duration(minutes: minutes));
    final snoozeId = _snoozeBaseId + (parsed.medicineId % 50);

    await _plugin.zonedSchedule(
      snoozeId,
      'SehatSaathi',
      'Reminder: medicine dose',
      now,
      _medicineDetails(payload),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  static Future<void> rescheduleAll({
    required List<Medicine> medicines,
    required AppSettings settings,
  }) async {
    await rescheduleMedicines(medicines);
    await rescheduleWaterReminders(settings);
    await rescheduleRefillAlerts(medicines);
  }

  static Future<void> maybeAlertMissedDoses({
    required List<ScheduledDose> missed,
    required AppSettings settings,
    required bool isHindi,
  }) async {
    if (!_ready || missed.isEmpty) return;
    final todayKey = DateOnly.key(DateOnly.today());
    if (settings.lastMissedAlertDateKey == todayKey) return;

    final count = missed.length;
    final body = isHindi
        ? 'आज $count दवा की खुराक छूट गई है। ऐप खोलकर देखें।'
        : 'You missed $count medicine dose(s) today. Open the app to review.';

    await _plugin.show(
      _missedId,
      'SehatSaathi',
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'sehat_medicine',
          'Medicine reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );

    settings.lastMissedAlertDateKey = todayKey;
    await IsarService.saveSettings(settings);
  }

  static Future<void> rescheduleDoctorVisits(List<DoctorVisit> visits) async {
    if (!_ready) return;
    await _cancelRange(_visitBaseId, _visitBaseId + 100);

    var offset = 0;
    final now = tz.TZDateTime.now(tz.local);

    for (final visit in visits) {
      if (visit.completed) continue;
      var scheduled = tz.TZDateTime.from(visit.visitAt, tz.local);
      if (scheduled.isBefore(now)) continue;

      // Remind 1 hour before if visit is far enough ahead.
      final reminder = scheduled.subtract(const Duration(hours: 1));
      if (reminder.isAfter(now)) {
        scheduled = reminder;
      }

      await _plugin.zonedSchedule(
        _visitBaseId + offset,
        'SehatSaathi — Doctor visit',
        'Upcoming: ${visit.doctorName}',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'sehat_visit',
            'Doctor visits',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'visit|${visit.id}',
      );
      offset++;
    }
  }
}
