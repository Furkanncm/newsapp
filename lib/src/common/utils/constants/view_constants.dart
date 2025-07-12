import 'package:flutter/widgets.dart';
import 'package:lucielle/lucielle.dart';

class ViewConstants {
  ViewConstants._init();
  static ViewConstants? _instance;
  static ViewConstants get instance {
    return _instance ??= ViewConstants._init();
  }

  final EdgeInsetsGeometry pagePadding =
      const LuciPadding.symetric() + const LuciPadding.horizontalSmall();
}
