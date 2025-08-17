import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/snackbar_enum.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class NewsAppSnackBar {
  static int _count = 0;

  static void show({
    required BuildContext context,
    required String text,
    required SnackBarType type,
  }) {
    _countSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: _setBackgroundColor(type),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _setBackgroundColor(type).withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _setIcon(type),
              horizontalBox8,
              Expanded(
                child: LuciText.bodySmall(
                  text,
                  textColor: AppTheme.buttonBackground,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Color _setBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return AppTheme.successColor;
      case SnackBarType.error:
        return AppTheme.errorColor;
      case SnackBarType.info:
        return AppTheme.primaryColor;
      case SnackBarType.warning:
        return AppTheme.warningColor;
    }
  }

  static void _hide(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static Icon _setIcon(SnackBarType type) {
    IconData icon;
    switch (type) {
      case SnackBarType.success:
        icon = Icons.check_circle_outline_outlined;
      case SnackBarType.error:
        icon = Icons.error_outline;
      case SnackBarType.info:
        icon = Icons.info_outline;
      case SnackBarType.warning:
        icon = Icons.warning_amber_outlined;
    }
    return Icon(icon, color: AppTheme.buttonBackground);
  }

  static void _countSnackBar(BuildContext context) {
    if (_count == 0) {
      _count++;
    } else {
      _count = 0;
      _hide(context);
    }
  }
}
