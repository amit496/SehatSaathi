import 'package:isar/isar.dart';

import 'enums.dart';

part 'medicine_dose_log.g.dart';

@collection
class MedicineDoseLog {
  Id id = Isar.autoIncrement;

  @Index()
  late String profileUuid;

  @Index()
  late int medicineId;

  @Index()
  late String dateKey;

  late String scheduledTime;

  @Enumerated(EnumType.name)
  late DoseStatus status;

  late DateTime updatedAt;
}
