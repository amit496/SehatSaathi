import 'package:isar/isar.dart';

import 'enums.dart';

part 'vitals_log.g.dart';

@collection
class VitalsLog {
  Id id = Isar.autoIncrement;

  @Index()
  late String profileUuid;

  @Enumerated(EnumType.name)
  late VitalsType type;

  int? systolic;

  int? diastolic;

  double? sugarMgDl;

  String note = '';

  late DateTime recordedAt;
}
