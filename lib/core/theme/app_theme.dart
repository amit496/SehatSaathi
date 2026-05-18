import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'brand.dart';

class AppTheme {
  static const primary = Brand.accent;
  static const primaryDark = Brand.accentDark;
  static const secondary = Brand.accentDeep;
  static const danger = Color(0xFFEF4444);
  static const success = Color(0xFF22C55E);

  static const lightBg = Color(0xFFF8FAFA);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightMuted = Color(0xFF64748B);
  static const lightBorder = Color(0xFFE2E8F0);
  static const lightText = Color(0xFF0F172A);

  static const darkBg = Color(0xFF0C1210);
  static const darkCard = Color(0xFF15201C);
  static const darkCardLight = Color(0xFF1E2E28);
  static const darkBorder = Color(0xFF2D3F38);
  static const darkMuted = Color(0xFF94A3B8);
  static const darkText = Color(0xFFF1F5F9);

  static Color primaryFor(BuildContext context) => Brand.accentFor(context);

  static Color mutedText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkMuted
        : lightMuted;
  }

  static BoxDecoration cardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? darkCard : lightCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: isDark ? darkBorder : lightBorder),
    );
  }

  static ThemeData get lightTheme => _build(Brightness.light);
  static ThemeData get darkTheme => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bg = isDark ? darkBg : lightBg;
    final card = isDark ? darkCard : lightCard;
    final text = isDark ? darkText : lightText;
    final muted = isDark ? darkMuted : lightMuted;
    final border = isDark ? darkBorder : lightBorder;
    final p = isDark ? primaryDark : primary;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: p,
        onPrimary: isDark ? darkBg : Colors.white,
        secondary: secondary,
        onSecondary: Colors.white,
        surface: bg,
        onSurface: text,
        onSurfaceVariant: muted,
        outline: border,
        error: danger,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: text,
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: -0.5,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: muted),
        bodyLarge: TextStyle(fontSize: 16, color: text, height: 1.4),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        backgroundColor: card,
        indicatorColor: p.withValues(alpha: 0.15),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final sel = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 11,
            fontWeight: sel ? FontWeight.w600 : FontWeight.w500,
            color: sel ? p : muted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final sel = states.contains(WidgetState.selected);
          return IconThemeData(color: sel ? p : muted, size: 24);
        }),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p,
        foregroundColor: isDark ? darkBg : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p,
          foregroundColor: isDark ? darkBg : Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border),
        ),
      ),
      dividerColor: border,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? darkCardLight : lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: p, width: 2),
        ),
      ),
    );
  }

  static SystemUiOverlayStyle overlayFor(bool isDark) => SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      );
}
