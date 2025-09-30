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
      dialogBackgroundColor: Theme.brightnessOf(context) == Brightness.light
          ? AppTheme.buttonBackground
          : AppTheme.bodyText,
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
      barrierDismissible: true,
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
      dialogBackgroundColor: Theme.brightnessOf(context) == Brightness.light
          ? AppTheme.buttonBackground
          : AppTheme.bodyText,
    );
  }

  static Future<void> infoDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) async {
    return LuciDialogs.infoDialog(
      context: context,
      title: title,
      content: content,
      label: LocaleKeys.yes.tr().toUpperCase(),
      primaryColor: AppTheme.primaryColor,
      dialogBackgroundColor: Theme.brightnessOf(context) == Brightness.light
          ? AppTheme.buttonBackground
          : AppTheme.bodyText,
    );
  }
}
