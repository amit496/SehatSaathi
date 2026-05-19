import 'package:flutter/material.dart';

/// Calm health palette — trustworthy, parent-friendly.
class Brand {
  Brand._();

  static const accent = Color(0xFF0D9488);
  static const accentDeep = Color(0xFF0F766E);
  static const wellness = Color(0xFF14B8A6);

  static Color accentFor(BuildContext context) => accent;

  static const splashGradient = LinearGradient(
    colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient splashFor(BuildContext context) => splashGradient;
}
