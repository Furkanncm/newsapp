import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';
import 'package:share_plus/share_plus.dart';

abstract class IUserRepository {
  User? get getCurrentUser;
  Future<XFile?> setProfilePhoto(BuildContext context);
  String? get getUserId;
  String? get getUserEmail;
  String? get getUserName;
  String? get getUserPhotoURL;
  FirebaseAuthEnum get authStatus;
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo);
}

class UserRepository extends IUserRepository {
  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource.instance;
  bool? isNewUser;

  @override
  User? get getCurrentUser => _firebaseDataSource.getCurrentUser();

  @override
  String? get getUserId => _firebaseDataSource.getUserId();

  @override
  String? get getUserEmail => _firebaseDataSource.getUserEmail();

  @override
  String? get getUserName => _firebaseDataSource.getUserName();

  @override
  String? get getUserPhotoURL => _firebaseDataSource.getUserPhotoURL();

  @override
  FirebaseAuthEnum get authStatus => _firebaseDataSource.authStatus;

  @override
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo) =>
      isNewUser = additionalUserInfo?.isNewUser;

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
