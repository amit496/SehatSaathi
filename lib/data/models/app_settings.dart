import 'package:isar/isar.dart';

import 'enums.dart';

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id id = 0;

  @Enumerated(EnumType.name)
  late AppLanguage language;

  late bool isDarkMode;

  late bool onboardingComplete;

  String? activeProfileUuid;

  late int waterGoalMl;

  late bool isPro;

  late bool waterRemindersEnabled;

  /// Reminder times as "HH:mm".
  List<String> waterReminderTimes = [];

  late int snoozeMinutes;

  late bool appLockEnabled;

  String? pinHash;

  String? lastMissedAlertDateKey;

  late DateTime updatedAt;
}
