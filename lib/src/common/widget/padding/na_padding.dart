import 'package:flutter/material.dart';

@immutable
final class NaPadding {
  const NaPadding._();
  static const EdgeInsets zeroPadding = EdgeInsets.zero;
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static const EdgeInsets onboardCounterPadding = EdgeInsets.symmetric(
    horizontal: 4,
  );
  static const EdgeInsets elevatedButtonPadding = EdgeInsets.all(12);
  static const EdgeInsets mainButtonPadding = EdgeInsets.symmetric(
    horizontal: 28,
    vertical: 20,
  );
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(
    horizontal: 12,
  );
  static const EdgeInsets rightPadding = EdgeInsets.only(right: 16);
  static const EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets verticalHighPadding = EdgeInsets.symmetric(
    vertical: 40,
  );
  static const EdgeInsets outlinedButtonPadding = EdgeInsets.symmetric(
    horizontal: 13,
    vertical: 3,
  );
}
