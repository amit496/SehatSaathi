import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'brand.dart';

class AppTheme {
  AppTheme._();

  static const primary = Brand.accent;
  static const secondary = Brand.accentDeep;
  static const danger = Color(0xFFEF4444);
  static const success = Color(0xFF22C55E);

  static const lightBg = Color(0xFFF8FAFA);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightMuted = Color(0xFF64748B);
  static const lightBorder = Color(0xFFE2E8F0);
  static const lightText = Color(0xFF0F172A);

  static Color primaryFor(BuildContext context) => Brand.accent;

  static Color mutedText(BuildContext context) => lightMuted;

  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: lightCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: lightBorder),
    );
  }

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBg,
        canvasColor: lightBg,
        colorScheme: const ColorScheme.light(
          primary: primary,
          onPrimary: Colors.white,
          secondary: secondary,
          onSecondary: Colors.white,
          surface: lightBg,
          onSurface: lightText,
          onSurfaceVariant: lightMuted,
          outline: lightBorder,
          error: danger,
          onError: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: lightBg,
          surfaceTintColor: Colors.transparent,
          foregroundColor: lightText,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: lightText,
            letterSpacing: -0.5,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: lightText,
          ),
          bodyMedium: TextStyle(fontSize: 14, color: lightMuted),
          bodyLarge: TextStyle(fontSize: 16, color: lightText, height: 1.4),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 64,
          backgroundColor: lightCard,
          indicatorColor: primary.withValues(alpha: 0.15),
          surfaceTintColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final sel = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 11,
              fontWeight: sel ? FontWeight.w600 : FontWeight.w500,
              color: sel ? primary : lightMuted,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final sel = states.contains(WidgetState.selected);
            return IconThemeData(color: sel ? primary : lightMuted, size: 24);
          }),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: lightCard,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: lightBorder),
          ),
        ),
        dividerColor: lightBorder,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightCard,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: lightBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: lightBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary, width: 2),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );

  static const lightOverlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: lightBg,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
