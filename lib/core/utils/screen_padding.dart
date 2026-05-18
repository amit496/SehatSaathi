import 'package:flutter/material.dart';

/// Bottom inset for the system navigation bar (3-button or gesture bar).
double systemBottomInset(BuildContext context) {
  final media = MediaQuery.of(context);
  return media.viewPadding.bottom > 0
      ? media.viewPadding.bottom
      : media.padding.bottom;
}

/// Scrollable page padding; adds space above the system nav bar.
EdgeInsets pagePadding(
  BuildContext context, {
  double left = 20,
  double top = 20,
  double right = 20,
  double bottom = 20,
}) {
  return EdgeInsets.fromLTRB(
    left,
    top,
    right,
    bottom + systemBottomInset(context),
  );
}
