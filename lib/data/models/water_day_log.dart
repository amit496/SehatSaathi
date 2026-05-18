import 'package:isar/isar.dart';

part 'water_day_log.g.dart';

@collection
class WaterDayLog {
  Id id = Isar.autoIncrement;

  @Index()
  late String profileUuid;

  @Index()
  late String dateKey;

  late int goalMl;

  late int consumedMl;

  late DateTime updatedAt;
}
