import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class VerifyButton extends StatelessWidget {
  const VerifyButton({
    required this.onPressed,
    required this.isValid,
    super.key,
    this.isVerified,
  });

  final VoidCallback onPressed;
  final bool isValid;
  final bool? isVerified;

  @override
  Widget build(BuildContext context) {
    if (isValid) return emptyBox;
    if (isVerified == null) return emptyBox;
    if (isVerified!) {
      return const Icon(Icons.check_circle_outline_outlined);
    } else {
      return TextButton(
        onPressed: () async => onPressed.call(),
        child: LuciText.bodyMedium(
          LocaleKeys.verify.tr(),
          textColor: Theme.brightnessOf(context) == Brightness.light
              ? AppTheme.bodyText
              : AppTheme.surfaceColor,
        ),
      );
    }
  }
}
