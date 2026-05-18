import '../../core/utils/date_utils.dart';
import '../../data/models/enums.dart';
import '../../data/models/medicine_dose_log.dart';
import '../../data/models/water_day_log.dart';
import '../../data/repositories/health_repository.dart';

class DayHealthStat {
  const DayHealthStat({
    required this.date,
    required this.dateKey,
    required this.medicinePercent,
    required this.waterPercent,
  });

  final DateTime date;
  final String dateKey;
  final int medicinePercent;
  final int waterPercent;
}

class WeeklyStatsBuilder {
  static List<DayHealthStat> build({
    required List<ScheduledDose> Function(DateTime day) dosesForDay,
    required List<MedicineDoseLog> allLogs,
    required List<WaterDayLog> waterLogs,
    int days = 7,
  }) {
    final stats = <DayHealthStat>[];
    final today = DateOnly.today();

    for (var i = days - 1; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final key = DateOnly.key(date);
      final scheduled = dosesForDay(date);
      final dayLogs =
          allLogs.where((l) => l.dateKey == key).toList(growable: false);
      WaterDayLog? water;
      for (final log in waterLogs) {
        if (log.dateKey == key) {
          water = log;
          break;
        }
      }

      var medicinePercent = 100;
      if (scheduled.isNotEmpty) {
        var taken = 0;
        for (final dose in scheduled) {
          final done = dayLogs.any(
            (l) =>
                l.medicineId == dose.medicine.id &&
                l.scheduledTime == dose.scheduledTime &&
                l.status == DoseStatus.taken,
          );
          if (done) taken++;
        }
        medicinePercent = ((taken / scheduled.length) * 100).round();
      }

      var waterPercent = 100;
      if (water != null && water.goalMl > 0) {
        waterPercent =
            ((water.consumedMl / water.goalMl).clamp(0.0, 1.0) * 100).round();
      }

      stats.add(
        DayHealthStat(
          date: date,
          dateKey: key,
          medicinePercent: medicinePercent,
          waterPercent: waterPercent,
        ),
      );
    }
    return stats;
  }
}
