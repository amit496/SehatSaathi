import 'package:isar/isar.dart';

import 'enums.dart';

part 'health_profile.g.dart';

@collection
class HealthProfile {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String name;

  @Enumerated(EnumType.name)
  late ProfileRelation relation;

  String? avatarPath;

  late bool isPrimary;

  late DateTime createdAt;
}
