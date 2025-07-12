import 'package:flutter/material.dart';

@immutable
final class NaPadding {
  const NaPadding._();
  static const EdgeInsets zeroPadding = EdgeInsets.zero;
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 18, vertical: 20);
  static const EdgeInsets onboardCounterPadding = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets elevatedButtonPadding = EdgeInsets.all(12);
}
