import 'package:isar/isar.dart';

part 'doctor_visit.g.dart';

@collection
class DoctorVisit {
  Id id = Isar.autoIncrement;

  late String profileUuid;

  late String doctorName;

  String clinic = '';

  String notes = '';

  late DateTime visitAt;

  late bool completed;
}
