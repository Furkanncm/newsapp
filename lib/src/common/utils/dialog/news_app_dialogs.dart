import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class NewsAppDialogs {
  static Future<void> confirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPositiveButton,
    String? positiveButtonLabel,
    String? negativeButtonLabel,
  }) async {
    return LuciDialogs.showDialog<void>(
      context: context,
      title: title,
      content: content,
      positiveButtonLabel:
          positiveButtonLabel ?? LocaleKeys.yes.tr().toUpperCase(),
      negativeButtonLabel:
          negativeButtonLabel ?? LocaleKeys.no.tr().toUpperCase(),
      positiveButtonCallback: onPositiveButton,
      primaryColor: AppTheme.primaryColor,
      dialogBackgroundColor: AppTheme.buttonBackground,
    );
  }

  static Future<void> logOutDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPositiveButton,
    String? positiveButtonLabel,
    String? negativeButtonLabel,
  }) async {
    return LuciDialogs.showDialog<void>(
      barrierDismissible: false,
      context: context,
      title: title,
      content: content,
      icon: Icons.logout_rounded,
      positiveButtonLabel:
          positiveButtonLabel ?? LocaleKeys.logOut.tr().toUpperCase(),
      negativeButtonLabel:
          negativeButtonLabel ?? LocaleKeys.cancel.toUpperCase(),
      positiveButtonCallback: onPositiveButton,
      primaryColor: AppTheme.primaryColor,
      dialogBackgroundColor: AppTheme.buttonBackground,
    );
  }

  static Future<void> infoDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog.adaptive(
          icon: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryColor, width: 4),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: AppTheme.primaryColor,
              size: 40,
            ),
          ),
          title: LuciText.titleMedium(title, fontWeight: FontWeight.bold),
          content: LuciText.bodyMedium(content),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: context.width * 0.8,
                child: Expanded(
                  child: LuciOutlinedButton(
                    borderColor: AppTheme.primaryColor,
                    borderSide: const BorderSide(
                      color: AppTheme.backgroundDark,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: LuciText.bodyMedium(
                      LocaleKeys.yes.tr(),
                      fontWeight: FontWeight.bold,
                      textColor: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
