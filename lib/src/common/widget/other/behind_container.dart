import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/decorations/na_border_radius.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class BehindContainer extends StatelessWidget {
  const BehindContainer({
    required this.isCurrentIndex,
    required this.selectedIcon,
    required this.unSelectedIcon,
    super.key,
  });

  final bool isCurrentIndex;
  final IconData selectedIcon;
  final IconData unSelectedIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: NaBorderRadius.extraLargeRadius(),
        color: isCurrentIndex
            ? AppTheme.primaryColor.withValues(alpha: 0.1)
            : null,
      ),
      child: Icon(isCurrentIndex ? selectedIcon : unSelectedIcon),
    );
  }
}
