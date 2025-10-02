import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth_enum.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/firestore/firestore_repository.dart';

abstract class IUserRepository {
  UserModel? get currentUser;

  User? get firebaseUser;

  String? get getUserId;

  String? get getUserEmail;

  String? get getUserName;

  String? get getUserPhotoURL;

  bool get isEmailVerified;

  FirebaseAuthEnum get authStatus;

  void setCurrentUser(UserModel user);

  void setIsNewUser(AdditionalUserInfo? additionalUserInfo);

  Future<UserModel?> getUserInfo();

  Future<void> setSkipped();

  Future<NetworkResponse<bool>> updateProfile({required UserModel user});

  Future<void> updateTopic({required List<Topic> topics});

  Future<bool> checkEmailVerified();

  Future<NetworkResponse<String>> updateProfilePhoto(String imagePath);
}

class UserRepository implements IUserRepository {
  factory UserRepository() {
    return _instance ??= UserRepository._();
  }
  UserRepository._() {
    _firestoreRepository = FirestoreRepository();
    _authRepository = AuthRepository();
  }
  static UserRepository? _instance;

  late final IFirestoreRepository _firestoreRepository;
  late final IAuthRepository _authRepository;

  @override
  UserModel? currentUser;

  @override
  User? get firebaseUser => _authRepository.firebaseUser;

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
  bool get isEmailVerified => currentUser?.isEmailVerified ?? false;

  @override
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo) =>
      _authRepository.isNewUser;

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

  //dev.furkankazimcam@gmail.com
  @override
  Future<void> updateTopic({required List<Topic> topics}) async {
    await _firestoreRepository.updateTopic(topics: topics);
  }

  @override
  Future<bool> checkEmailVerified() async {
    final user = _authRepository.firebaseUser;
    if (user == null) return false;

    await user.reload();
    return user.emailVerified;
  }

  @override
  Future<NetworkResponse<String>> updateProfilePhoto(String imagePath) {
    return _firestoreRepository.updateProfilePhoto(
      user: currentUser!.copyWith(profilePhoto: imagePath),
    );
  }
}
