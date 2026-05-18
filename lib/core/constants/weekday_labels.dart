import '../l10n/app_strings.dart';

class WeekdayLabels {
  static const weekdays = [1, 2, 3, 4, 5, 6, 7];

  static String short(int day, AppStrings s) {
    if (!s.isHindi) {
      return switch (day) {
        1 => 'Mon',
        2 => 'Tue',
        3 => 'Wed',
        4 => 'Thu',
        5 => 'Fri',
        6 => 'Sat',
        7 => 'Sun',
        _ => '$day',
      };
    }
    return switch (day) {
      1 => 'सोम',
      2 => 'मंगल',
      3 => 'बुध',
      4 => 'गुरु',
      5 => 'शुक्र',
      6 => 'शनि',
      7 => 'रवि',
      _ => '$day',
    };
  }
}
