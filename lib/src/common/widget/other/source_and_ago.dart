import 'package:codegen/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class SourceAndAgoWidget extends StatelessWidget {
  const SourceAndAgoWidget({
    required this.source,
    required this.pastTime,
    super.key,
  });

  final String source;
  final String pastTime;
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.brightnessOf(context) == Brightness.light
        ? AppTheme.bodyText
        : AppTheme.bodyDark;
    return Row(
      children: [
        LuciText.bodySmall(
          source,
          fontWeight: FontWeight.w500,
          textColor: textColor,
        ),
        const Spacer(),
        Assets.uiKitImages.icTimeOutline.toIcon(16),
        horizontalBox4,
        LuciText.bodySmall(pastTime, textColor: textColor),
      ],
    );
  }
}
