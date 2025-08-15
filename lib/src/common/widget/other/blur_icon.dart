import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class BlurIcon extends StatelessWidget {
  const BlurIcon({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ColoredBox(
            color: AppTheme.inputDark.withValues(alpha: 0.3),
            child: child,
          ),
        ),
      ),
    );
  }
}
