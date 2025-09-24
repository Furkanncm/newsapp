import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/firebase_firestore/firebase_firestore_repository.dart';
import 'package:share_plus/share_plus.dart';

abstract class IUserRepository {
  UserModel? get currentUser;
  Future<XFile?> setProfilePhoto(BuildContext context);
  String? get getUserId;
  String? get getUserEmail;
  String? get getUserName;
  String? get getUserPhotoURL;
  FirebaseAuthEnum get authStatus;
  void setCurrentUser(UserModel user);
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo);
  Future<UserModel?> getUserInfo();
  Future<void> setSkipped();
  Future<NetworkResponse<bool>> updateProfile({required UserModel user});
  Future<void> updateTopic({required List<Topic> topics});
}

class UserRepository implements IUserRepository {
  factory UserRepository() {
    return _instance ??= UserRepository._();
  }
  UserRepository._() {
    _firestoreRepository = FirebaseFirestoreRepository();
    _authRepository = AuthRepository();
  }
  static UserRepository? _instance;

  late final IFirebaseFirestoreRepository _firestoreRepository;
  late final IAuthRepository _authRepository;

  @override
  UserModel? currentUser;

  @override
  String? get getUserId => currentUser?.id;

  @override
  String? get getUserEmail => currentUser?.email;

  @override
  String? get getUserName => currentUser?.name;

  @override
  String? get getUserPhotoURL => currentUser?.profilePhoto;

  @override
  FirebaseAuthEnum get authStatus => _authRepository.authStatus;

  @override
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo) =>
      _authRepository.isNewsUser;

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
    return result;
  }

  @override
  Future<UserModel?> getUserInfo() async {
    final user = await _firestoreRepository.getUserInfo();
    setCurrentUser(user);
    return user;
  }

  @override
  void setCurrentUser(UserModel? user) {
    if (user == null) return;
    currentUser = user;
  }

  @override
  Future<void> setSkipped() async {
    await _firestoreRepository.updateProfile(
      currentUser!.copyWith(isSkipped: true),
    );
  }

  @override
  Future<NetworkResponse<bool>> updateProfile({required UserModel user}) async {
    return _firestoreRepository.updateProfile(
      user.copyWith(id: currentUser?.id ?? ''),
    );
  }

  @override
  Future<void> updateTopic({required List<Topic> topics}) async {
    await _firestoreRepository.updateTopic(topics: topics);
  }
}
