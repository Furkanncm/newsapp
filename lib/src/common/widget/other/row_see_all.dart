import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class RowSeeAllWidget extends StatelessWidget {
  const RowSeeAllWidget({
    required this.text,
    required this.onSeeAllPressed,
    super.key,
  });

  final String text;
  final VoidCallback onSeeAllPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LuciText.bodyLarge(text, fontWeight: FontWeight.bold),
        const Spacer(),
        GestureDetector(
          onTap: onSeeAllPressed,
          child: LuciText.bodySmall('See All', textColor: AppTheme.bodyText),
        ),
      ],
    );
  }
}
