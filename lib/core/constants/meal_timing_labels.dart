import '../../data/models/enums.dart';
import '../l10n/app_strings.dart';

class MealTimingLabels {
  static String label(MealTiming timing, AppStrings s) {
    if (!s.isHindi) {
      return switch (timing) {
        MealTiming.beforeMeal => 'Before meal',
        MealTiming.afterMeal => 'After meal',
        MealTiming.anyTime => 'Any time',
      };
    }
    return switch (timing) {
      MealTiming.beforeMeal => 'खाने से पहले',
      MealTiming.afterMeal => 'खाने के बाद',
      MealTiming.anyTime => 'कभी भी',
    };
  }
}
