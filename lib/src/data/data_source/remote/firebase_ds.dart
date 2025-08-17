import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsapp/firebase_options.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/constants/firebase_error.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth.dart';
import 'package:newsapp/src/common/utils/enums/firebase_collection.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';

abstract class IFirebaseDataSource {
  Future<void> initialize();
  User? getCurrentUser();
  String? getUserId();
  String? getUserEmail();
  String? getUserName();
  String? getUserPhotoURL();
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo);
  Future<NetworkResponse<bool>> register({
    required String email,
    required String password,
    bool isRememberMe = false,
  });
  Future<NetworkResponse<bool>> logInWithEmail({
    required String email,
    required String password,
    bool isRememberMe = false,
  });
  Future<void> logOut();
  void saveUser({required UserModel user});
  void updateProfile({required User user});
}

class FirebaseDataSource implements IFirebaseDataSource {
  FirebaseDataSource._();

  static FirebaseDataSource? _instance;

  static FirebaseDataSource get instance {
    _instance ??= FirebaseDataSource._();
    return _instance!;
  }

  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;
  late final CacheRepository _cacheRepository = CacheRepository.instance;

  bool? isNewUser;

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firebaseAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  @override
  User? getCurrentUser() => _firebaseAuth.currentUser;

  @override
  String? getUserId() => _firebaseAuth.currentUser?.uid;

  @override
  String? getUserEmail() => _firebaseAuth.currentUser?.email;

  @override
  String? getUserName() => _firebaseAuth.currentUser?.displayName;

  @override
  String? getUserPhotoURL() => _firebaseAuth.currentUser?.photoURL;

  @override
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo) =>
      isNewUser = additionalUserInfo?.isNewUser;
  FirebaseAuthEnum authStatus = FirebaseAuthEnum.unauthenticated;

  @override
  Future<NetworkResponse<bool>> logInWithEmail({
    required String email,
    required String password,
    bool isRememberMe = false,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        await _isRememberMeAndSetAuthStatus(
          isRememberMe: isRememberMe,
          userId: user.uid,
        );
        return NetworkResponse.success(data: true);
      }
    } on FirebaseAuthException catch (e) {
      return FirebaseError.errorInfo(e);
    }
    return NetworkResponse.failure(message: LocaleKeys.unknownError.tr());
  }

  @override
  Future<NetworkResponse<bool>> register({
    required String email,
    required String password,
    bool isRememberMe = false,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setIsNewUser(userCredential.additionalUserInfo);
      final user = userCredential.user;

      if (user != null) {
        await _isRememberMeAndSetAuthStatus(
          isRememberMe: isRememberMe,
          userId: user.uid,
        );

        await saveUser(
          user: UserModel(id: user.uid, email: email, password: password),
        );

        return NetworkResponse.success(data: true);
      }
    } on FirebaseAuthException catch (e) {
      return FirebaseError.errorInfo(e);
    }
    return NetworkResponse.failure(message: LocaleKeys.unknownError.tr());
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    await _cacheRepository.remove(PrefKeys.isUserLoggedIn);
    authStatus = FirebaseAuthEnum.unauthenticated;
  }

  @override
  Future<void> saveUser({required UserModel user}) async {
    await _firestore
        .collection(FirebaseCollection.users.collectionName)
        .doc(user.id)
        .set(user.toJson());
  }

  @override
  void updateProfile({required User user}) {
    // Implement profile update logic using Firebase Firestore
  }

  Future<void> _isRememberMeAndSetAuthStatus({
    required bool isRememberMe,
    required String userId,
  }) async {
    if (isRememberMe) {
      await _cacheRepository.setString(PrefKeys.isUserLoggedIn, userId);
    }
    authStatus = FirebaseAuthEnum.authenticated;
  }
}
