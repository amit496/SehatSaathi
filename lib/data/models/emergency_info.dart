import 'package:isar/isar.dart';

part 'emergency_info.g.dart';

@collection
class EmergencyInfo {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String profileUuid;

  String bloodGroup = '';

  String contactName = '';

  String contactPhone = '';

  String allergies = '';

  String currentMedicines = '';

  late DateTime updatedAt;
}
