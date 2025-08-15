import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:share_plus/share_plus.dart';

abstract class IUserRepository {
  Future<XFile?> setProfilePhoto(BuildContext context);
}

class UserRepository extends IUserRepository {
  @override
  Future<XFile?> setProfilePhoto(BuildContext context) async {
    final result = await ImagePickerBottomSheet().showImagePickerBottomSheet(
      context: context,
      locale: context.locale,
      showDragHandle: true,
      bottomSheetBackgroundColor: AppTheme.buttonBackground,
      iconColor: AppTheme.primaryColor,
      buttonBackgroundColor: AppTheme.bodyDark,
    );
    if (result == null) return null;
    // Firebase kayıt
    return result;
  }
}
