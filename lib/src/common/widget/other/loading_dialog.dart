import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/decorations/na_border_radius.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/circular_progress.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.brightnessOf(context) == Brightness.light;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: NaBorderRadius.mediumRadius(),
          boxShadow: kElevationToShadow[4],
          color: isLightTheme
              ? AppTheme.buttonBackground
              : AppTheme.backgroundDark,
        ),
        width: 75,
        height: 75,
        child: const AdaptiveCircular.withoutExpanded(),
      ),
    );
  }
}
