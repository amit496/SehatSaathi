import 'package:flutter/material.dart';

/// Calm health palette — trustworthy, parent-friendly.
class Brand {
  Brand._();

  static const accent = Color(0xFF0D9488);
  static const accentDark = Color(0xFF2DD4BF);
  static const accentDeep = Color(0xFF0F766E);
  static const wellness = Color(0xFF14B8A6);

  static Color accentFor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? accentDark
        : accent;
  }

  static const splashGradient = LinearGradient(
    colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const splashGradientDark = LinearGradient(
    colors: [Color(0xFF042F2E), Color(0xFF134E4A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient splashFor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? splashGradientDark
        : splashGradient;
  }
}
