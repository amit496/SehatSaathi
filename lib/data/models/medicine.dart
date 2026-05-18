import 'package:isar/isar.dart';

import 'enums.dart';

part 'medicine.g.dart';

@collection
class Medicine {
  Id id = Isar.autoIncrement;

  @Index()
  late String profileUuid;

  late String name;

  late String dose;

  String? photoPath;

  /// Times as "HH:mm" strings.
  List<String> times = [];

  /// Weekdays 1=Mon … 7=Sun
  List<int> repeatDays = [];

  @Enumerated(EnumType.name)
  late MealTiming mealTiming;

  String mealNote = '';

  int? refillDaysLeft;

  late bool refillAlertEnabled;

  late bool archived;

  late DateTime createdAt;
}
