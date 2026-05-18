import 'package:isar/isar.dart';

import 'enums.dart';

part 'mood_log.g.dart';

@collection
class MoodLog {
  Id id = Isar.autoIncrement;

  @Index()
  late String profileUuid;

  @Index()
  late String dateKey;

  @Enumerated(EnumType.name)
  late MoodLevel mood;

  String note = '';

  late DateTime createdAt;
}
