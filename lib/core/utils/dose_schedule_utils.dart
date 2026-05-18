import '../../data/models/enums.dart';
import '../../data/models/medicine_dose_log.dart';
import '../../data/repositories/health_repository.dart';

class DoseScheduleUtils {
  DoseScheduleUtils._();

  static const defaultGraceMinutes = 30;

  static DateTime scheduledToday(String timeHHmm) {
    final parts = timeHHmm.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  static bool isMissed(
    ScheduledDose dose,
    List<MedicineDoseLog> logs, {
    int graceMinutes = defaultGraceMinutes,
  }) {
    final due = scheduledToday(dose.scheduledTime)
        .add(Duration(minutes: graceMinutes));
    if (DateTime.now().isBefore(due)) return false;

    final log = logs.where(
      (l) =>
          l.medicineId == dose.medicine.id &&
          l.scheduledTime == dose.scheduledTime &&
          l.dateKey == dose.dateKey,
    );
    if (log.isEmpty) return true;
    return log.first.status == DoseStatus.pending;
  }

  static List<ScheduledDose> missedDoses(
    List<ScheduledDose> scheduled,
    List<MedicineDoseLog> logs, {
    int graceMinutes = defaultGraceMinutes,
  }) =>
      scheduled
          .where((d) => isMissed(d, logs, graceMinutes: graceMinutes))
          .toList();
}
