import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class RowSeeAllWidget extends StatelessWidget {
  const RowSeeAllWidget({
    required this.text,
    this.onSeeAllPressed,
    this.isSeeAllVisible = true,
    super.key,
  });

  final String text;
  final VoidCallback? onSeeAllPressed;
  final bool isSeeAllVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LuciText.bodyLarge(text, fontWeight: FontWeight.bold),
        const Spacer(),
        Visibility(
          visible: isSeeAllVisible,
          child: GestureDetector(
            onTap: onSeeAllPressed,
            child: LuciText.bodySmall(
              LocaleKeys.seeAll.tr(),
              textColor: AppTheme.bodyText,
            ),
          ),
        ),
      ],
    );
  }
}
