import 'package:flutter_test/flutter_test.dart';
import 'package:sehat_saathi/core/utils/health_score.dart';

void main() {
  test('daily health score with water only', () {
    final score = HealthScoreCalculator.dailyScore(
      scheduled: const [],
      logs: const [],
      waterConsumed: 1250,
      waterGoal: 2500,
    );
    expect(score, 50);
  });

  test('daily health score combines medicine and water', () {
    final score = HealthScoreCalculator.dailyScore(
      scheduled: const [],
      logs: const [],
      waterConsumed: 2500,
      waterGoal: 2500,
    );
    expect(score, 100);
  });
}
