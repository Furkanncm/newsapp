import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/constants/firebase_error.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/firebase_firestore/firebase_firestore_repository.dart';
import 'package:newsapp/src/domain/localization/localization_repository.dart';

abstract class IAuthRepository {
  FirebaseAuthEnum authStatus = FirebaseAuthEnum.unauthenticated;

  bool? isNewUser;

  final String verificationId = '';

  User? get firebaseUser;

  Future<NetworkResponse<bool>> logInWithEmail({
    required String email,
    required String password,
    bool isRememberMe,
  });

  Future<NetworkResponse<String>?> loginWithGoogle();

  Future<NetworkResponse<bool>> register({
    required String email,
    required String password,
    bool isRememberMe,
  });

  Future<void> logOut();

  Future<NetworkResponse<bool>> sendVerificationCodePhoneNumber({
    required OTPModel model,
  });

  Future<NetworkResponse<bool>?> sendVerificationEmail();

  Future<NetworkResponse<bool>> verifyPhoneNumber({required String smsCode});

  Future<void> resetPasswordWithEmail({required String email});

  Future<void> updatePassword(String newPassword);
}

final class AuthRepository implements IAuthRepository {
  factory AuthRepository() {
    return _instance ??= AuthRepository._();
  }
  AuthRepository._() {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.setLanguageCode(
      LocalizationManager.instance.foolbackLocale?.countryCode,
    );
    _firestoreRepository = FirebaseFirestoreRepository();
    _cacheRepository = CacheRepository.instance;
    _googleSignIn = GoogleSignIn();
    _countryRepository = CountryRepository();
  }
  static AuthRepository? _instance;

  late final FirebaseAuth _firebaseAuth;
  late final IFirebaseFirestoreRepository _firestoreRepository;
  late final CacheRepository _cacheRepository;
  late final GoogleSignIn _googleSignIn;
  late final CountryRepository _countryRepository;

  @override
  FirebaseAuthEnum authStatus = FirebaseAuthEnum.unauthenticated;

  @override
  bool? isNewUser;

  @override
  String verificationId = '';

  void setIsNewUser(AdditionalUserInfo? additionalUserInfo) =>
      isNewUser = additionalUserInfo?.isNewUser;

  @override
  User? get firebaseUser => _firebaseAuth.currentUser;

  @override
  Future<NetworkResponse<bool>> logInWithEmail({
    required String email,
    required String password,
    bool isRememberMe = false,
  }) {
    return _withTryCatch(() async {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await _setAuth(
          userCredential: userCredential,
          isRememberMe: isRememberMe,
        );
        return true;
      }
      return null;
    });
  }

  @override
  Future<NetworkResponse<String>> loginWithGoogle() {
    return _withTryCatch(() async {
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
          await _setAuth(userCredential: userCredential, isRememberMe: true);
          return user.uid;
        }
      }
      return null;
    });
  }

  @override
  Future<NetworkResponse<bool>> register({
    required String email,
    required String password,
    bool isRememberMe = false,
  }) {
    return _withTryCatch(() async {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setIsNewUser(userCredential.additionalUserInfo);

      final user = userCredential.user;
      if (user != null) {
        await _setAuth(
          userCredential: userCredential,
          isRememberMe: isRememberMe,
        );
        return true;
      }
      return null;
    });
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    await _cacheRepository.remove(PrefKeys.isUserLoggedIn);
    authStatus = FirebaseAuthEnum.unauthenticated;
  }

  @override
  Future<NetworkResponse<bool>> sendVerificationCodePhoneNumber({
    required OTPModel model,
  }) async {
    return _withTryCatch<bool>(() async {
      final selectedCountry = _countryRepository.selectedCountry;
      final cleanedPhoneNumber =
          '+${selectedCountry?.phoneCode ?? 90}${model.otpContent}'.replaceAll(
            RegExp('[^0-9+]'),
            '',
          );

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: cleanedPhoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async =>
            _firebaseAuth.signInWithCredential(credential),
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(
            '${LocaleKeys.phoneFailed.tr()}: ${e.code} - ${e.message}',
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          router.pushNamed(
            RoutePaths.otpVerification.name,
            extra: OTPModel(
              otpOptions: model.otpOptions,
              otpContent: cleanedPhoneNumber,
            ),
          );
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );

      return null;
    });
  }

  @override
  Future<NetworkResponse<bool>> verifyPhoneNumber({required String smsCode}) {
    return _withTryCatch(() async {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user != null) {
        await _firestoreRepository.saveUser(
          user: const UserModel(isPhoneNumberVerified: true),
        );
        return true;
      }
      return null;
    });
  }

  @override
  Future<NetworkResponse<bool>> sendVerificationEmail() {
    return _withTryCatch(() async {
      if (firebaseUser == null) return null;
      await firebaseUser!.sendEmailVerification();
      await firebaseUser!.reload();
      return firebaseUser!.emailVerified;
    });
  }

  @override
  Future<NetworkResponse<bool>> resetPasswordWithEmail({
    required String email,
  }) {
    return _withTryCatch(() async {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    });
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    if (firebaseUser == null) return;
    await firebaseUser!.updatePassword(newPassword);
  }

  Future<void> _setAuth({
    required UserCredential userCredential,
    required bool isRememberMe,
  }) async {
    if (firebaseUser == null) return;
    await _firestoreRepository.setAuthAndSaveUser(
      isRememberMe: isRememberMe,
      user: firebaseUser!.toUserModel(),
      isNewsUser: userCredential.additionalUserInfo?.isNewUser ?? false,
    );
    authStatus = FirebaseAuthEnum.authenticated;
  }

  Future<NetworkResponse<T>> _withTryCatch<T>(
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
    } catch (e) {
      return NetworkResponse.failure(message: e.toString());
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
