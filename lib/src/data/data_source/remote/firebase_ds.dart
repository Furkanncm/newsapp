import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsapp/firebase_options.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/constants/firebase_error.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth.dart';
import 'package:newsapp/src/common/utils/enums/firebase_collection.dart';
import 'package:newsapp/src/common/utils/enums/otp_options_enum.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';

abstract class IFirebaseDataSource {
  Future<void> initialize();

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
  Future<UserModel?> getUserInfo();
  Future<NetworkResponse<String>?> loginWithGoogle();
  Future<NetworkResponse<bool>> updateProfile(UserModel user);
  Future<void> updateTopic({required List<Topic> topics});
  Future<void> sendVerificationCodePhoneNumber({required String phoneNumber});
  Future<NetworkResponse<bool>> verifyPhoneNumber({required String smsCode});
  Future<NetworkResponse<bool>?> sendVerificationEmail();
  Future<void> saveNews(Article article);
  Future<void> removeNews(Article article);
  Future<List<Article>> getNews();
  Future<void> resetPasswordWithEmail({required String email});
  FirebaseAuthEnum authStatus = FirebaseAuthEnum.unauthenticated;
  bool? isNewUser;
  User? firebaseUser;
  String get userId;
}

class FirebaseDataSource {
  factory FirebaseDataSource() {
    return _instance ??= FirebaseDataSource._();
  }
  FirebaseDataSource._();
  static FirebaseDataSource? _instance;

  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;
  late final CacheRepository _cacheRepository = CacheRepository.instance;
  late final GoogleSignIn _googleSignIn;
  late final CountryRepository _countryRepository;
  @override
  String get userId =>
      _cacheRepository.getString(PrefKeys.isUserLoggedIn) ?? '';

  @override
  bool? isNewUser;

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firebaseAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _googleSignIn = GoogleSignIn();
    _countryRepository = CountryRepository();
  }

  @override
  User? firebaseUser;

  @override
  void setIsNewUser(AdditionalUserInfo? additionalUserInfo) =>
      isNewUser = additionalUserInfo?.isNewUser;
  @override
  FirebaseAuthEnum authStatus = FirebaseAuthEnum.unauthenticated;

  // @override
  // Future<NetworkResponse<bool>> logInWithEmail({
  //   required String email,
  //   required String password,
  //   bool isRememberMe = false,
  // }) async {
  //   try {
  //     final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final user = userCredential.user;

  //     if (user != null) {
  //       firebaseUser = user;
  //       await _setAuthAndSaveUser(
  //         isRememberMe: isRememberMe,
  //         user: user.toUserModel(),
  //         isNewsUser: userCredential.additionalUserInfo?.isNewUser ?? false,
  //       );
  //       await _cacheRepository.setString(PrefKeys.isUserLoggedIn, user.uid);
  //       return NetworkResponse.success(data: true);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return FirebaseError.errorInfo(e);
  //   }
  //   return NetworkResponse.failure(message: LocaleKeys.unknownError.tr());
  // }

  @override
  Future<NetworkResponse<String>?> loginWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth?.idToken != null && googleAuth?.accessToken != null) {
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
          accessToken: googleAuth?.accessToken,
        );

        final userCredential = await _firebaseAuth.signInWithCredential(
          credential,
        );
        final user = userCredential.user;

        if (user != null) {
          firebaseUser = user;
          await _setAuthAndSaveUser(
            isRememberMe: true,
            user: user.toUserModel(),
            isNewsUser: userCredential.additionalUserInfo?.isNewUser ?? false,
          );

          return NetworkResponse.success(data: user.uid);
        }
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
        firebaseUser = user;
        await _setAuthAndSaveUser(
          isRememberMe: isRememberMe,
          user: user.toUserModel(),
          isNewsUser: userCredential.additionalUserInfo?.isNewUser ?? false,
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
    firebaseUser = null;
  }

  @override
  Future<void> saveUser({required UserModel user}) async {
    await _firestore
        .collection(FirebaseCollection.users.collectionName)
        .doc(user.id)
        .set(user.toJson());

    await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(user.id)
        .set({
          FirebaseCollection.savedNews.collectionName: List<String>.empty(),
        });
  }

  @override
  Future<void> resetPasswordWithEmail({required String email}) async {
    await withTryCatch(() async {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    });
  }

  @override
  Future<NetworkResponse<bool>> updateProfile(UserModel user) async {
    try {
      await _firestore
          .collection(FirebaseCollection.users.collectionName)
          .doc(user.id)
          .update(user.toJson());
      return NetworkResponse.success(data: true);
    } on FirebaseAuthException catch (e) {
      return NetworkResponse.failure(message: e.message ?? '');
    }
  }

  @override
  Future<void> updateTopic({required List<Topic> topics}) async {
    await _firestore
        .collection(FirebaseCollection.users.collectionName)
        .doc(userId)
        .update({'topics': topics.map((e) => e.toJson()).toList()});
  }

  @override
  Future<UserModel?> getUserInfo() async {
    final snapshot = await _firestore
        .collection(FirebaseCollection.users.collectionName)
        .doc(userId)
        .get();
    if (!snapshot.exists) return null;
    return UserModel.fromJson(snapshot.data()!);
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

  Future<void> _setAuthAndSaveUser({
    required bool isRememberMe,
    required UserModel user,
    bool isNewsUser = false,
  }) async {
    if (user.id == null) return;
    await _cacheRepository.setString(PrefKeys.isUserLoggedIn, user.id!);
    await _isRememberMeAndSetAuthStatus(
      isRememberMe: isRememberMe,
      userId: user.id!,
    );
    if (!isNewsUser) return;
    await saveUser(user: user);
  }

  String _verificationId = '';

  @override
  Future<void> sendVerificationCodePhoneNumber({
    required String phoneNumber,
  }) async {
    final selectedCountry = _countryRepository.selectedCountry;
    final cleanedPhoneNumber =
        '+${selectedCountry?.phoneCode ?? 90}$phoneNumber'.replaceAll(
          RegExp('[^0-9+]'),
          '',
        );
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: cleanedPhoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async =>
          _firebaseAuth.signInWithCredential(credential),
      verificationFailed: (FirebaseAuthException e) {
        debugPrint('Phone verification failed: ${e.code} - ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        router.pushNamed(
          RoutePaths.otpVerification.name,
          extra: OTPModel(
            otpOptions: OTPOptions.sms,
            otpContent: cleanedPhoneNumber,
          ),
        );
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  @override
  Future<NetworkResponse<bool>?> sendVerificationEmail() async {
    if (firebaseUser == null) return null;
    try {
      await firebaseUser!.sendEmailVerification();
      return NetworkResponse.success(data: true);
    } on FirebaseAuthException catch (e) {
      return FirebaseError.errorInfo(e);
    }
  }

  @override
  Future<NetworkResponse<bool>> verifyPhoneNumber({
    required String smsCode,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user != null) {
        await saveUser(user: const UserModel(isPhoneNumberVerified: true));
        return NetworkResponse.success(data: true);
      }
    } on FirebaseAuthException catch (e) {
      return NetworkResponse.failure(
        message: e.message ?? LocaleKeys.unknownError.tr(),
      );
    }
    return NetworkResponse.failure(message: LocaleKeys.unknownError.tr());
  }

  Future<void> updatePassword(String newPassword) async {
    if (firebaseUser == null) return;
    await firebaseUser!.updatePassword(newPassword);
  }

  @override
  Future<void> saveNews(Article article) async {
    await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(userId)
        .update({
          FirebaseCollection.savedNews.collectionName: FieldValue.arrayUnion([
            article.toJson(),
          ]),
        });
  }

  @override
  Future<void> removeNews(Article article) async {
    await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(userId)
        .update({
          FirebaseCollection.savedNews.collectionName: FieldValue.arrayRemove([
            article.toJson(),
          ]),
        });
  }

  @override
  Future<List<Article>> getNews() async {
    final snapshot = await _firestore
        .collection(FirebaseCollection.news.collectionName)
        .doc(userId)
        .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null) {
        final articlesData =
            data[FirebaseCollection.savedNews.collectionName] as List<dynamic>?;
        if (articlesData == null) return [];
        return articlesData
            .map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  Future<NetworkResponse<T>> withTryCatch<T>(
    Future<T?> Function() onSuccess,
  ) async {
    try {
      final result = await onSuccess.call();
      if (result != null) {
        return NetworkResponse.success(data: result);
      }
      return NetworkResponse.failure(message: LocaleKeys.unknownError.tr());
    } on FirebaseAuthException catch (e) {
      return FirebaseError.errorInfo(e);
    } catch (_) {
      return NetworkResponse.failure(message: LocaleKeys.unknownError.tr());
    }
  }
}

extension Userss on User {
  UserModel toUserModel() {
    return UserModel(
      id: uid,
      email: email,
      isEmailVerified: emailVerified,
      name: displayName,
    );
  }
}
