import '../../data/models/enums.dart';
import '../../data/models/medicine_dose_log.dart';
import '../../data/repositories/health_repository.dart';

class HealthScoreCalculator {
  static int dailyScore({
    required List<ScheduledDose> scheduled,
    required List<MedicineDoseLog> logs,
    required int waterConsumed,
    required int waterGoal,
  }) {
    if (scheduled.isEmpty && waterGoal <= 0) return 0;

    var medicineScore = 100;
    if (scheduled.isNotEmpty) {
      var taken = 0;
      for (final dose in scheduled) {
        final log = logs.where(
          (l) =>
              l.medicineId == dose.medicine.id &&
              l.scheduledTime == dose.scheduledTime &&
              l.status == DoseStatus.taken,
        );
        if (log.isNotEmpty) taken++;
      }
      medicineScore = ((taken / scheduled.length) * 100).round();
    }

    final waterScore = waterGoal > 0
        ? ((waterConsumed / waterGoal).clamp(0.0, 1.0) * 100).round()
        : 100;

    if (scheduled.isEmpty) return waterScore;
    if (waterGoal <= 0) return medicineScore;
    return ((medicineScore + waterScore) / 2).round();
  }
}
