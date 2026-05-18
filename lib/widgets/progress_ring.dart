import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    required this.label,
    this.size = 88,
    this.stroke = 8,
  });

  final double progress;
  final String label;
  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    final p = progress.clamp(0.0, 1.0);
    final color = AppTheme.primaryFor(context);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: p,
              strokeWidth: stroke,
              backgroundColor: color.withValues(alpha: 0.15),
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size * 0.18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
