import 'package:flutter/material.dart';

class SehatLogo extends StatelessWidget {
  const SehatLogo({
    super.key,
    this.size = 64,
    this.whiteOnBrand = false,
  });

  final double size;
  final bool whiteOnBrand;

  @override
  Widget build(BuildContext context) {
    final color = whiteOnBrand ? Colors.white : Theme.of(context).colorScheme.primary;
    return Icon(Icons.favorite_rounded, size: size, color: color);
  }
}
