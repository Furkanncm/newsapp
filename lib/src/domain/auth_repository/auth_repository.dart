import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';

abstract class IAuthRepository {
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

  Future<void> sendVerificationCodePhoneNumber({required String phoneNumber});

  Future<NetworkResponse<bool>> verifyPhoneNumber({required String smsCode});

  FirebaseAuthEnum get authStatus;

  bool? get isNewsUser;
}

final class AuthRepository implements IAuthRepository {
  factory AuthRepository() {
    return _instance ??= AuthRepository._();
  }
  AuthRepository._() {
    _firebaseDataSource = FirebaseDataSource();
  }
  static AuthRepository? _instance;

  late final IFirebaseDataSource _firebaseDataSource;

  @override
  FirebaseAuthEnum get authStatus => _firebaseDataSource.authStatus;

  @override
  bool? get isNewsUser => _firebaseDataSource.isNewUser;

  @override
  Future<NetworkResponse<bool>> logInWithEmail({
    required String email,
    required String password,
    bool isRememberMe = false,
  }) async =>
      _firebaseDataSource.logInWithEmail(email: email, password: password);

  @override
  Future<NetworkResponse<String>?> loginWithGoogle() async =>
      _firebaseDataSource.loginWithGoogle();

  @override
  Future<NetworkResponse<bool>> register({
    required String email,
    required String password,
    bool isRememberMe = false,
  }) async => _firebaseDataSource.register(email: email, password: password);

  @override
  Future<void> logOut() async => _firebaseDataSource.logOut();

  @override
  Future<void> sendVerificationCodePhoneNumber({
    required String phoneNumber,
  }) async => _firebaseDataSource.sendVerificationCodePhoneNumber(
    phoneNumber: phoneNumber,
  );

  @override
  Future<NetworkResponse<bool>> verifyPhoneNumber({
    required String smsCode,
  }) async => _firebaseDataSource.verifyPhoneNumber(smsCode: smsCode);
}
