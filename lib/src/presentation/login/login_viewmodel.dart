import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'login_viewmodel.g.dart';

class LoginViewmodel = _LoginViewmodelBase with _$LoginViewmodel;

abstract class _LoginViewmodelBase with Store {
  late final IAuthRepository authRepository;
  late final IUserRepository userRepository;
  late final CacheRepository cacheRepository;

  @observable
  bool isRememberMe = true;

  @observable
  bool isLoading = false;

  Future<NetworkResponse<bool>?> login({
    required String email,
    required String password,
  }) async {
    return authRepository.logInWithEmail(
      email: email,
      password: password,
      isRememberMe: isRememberMe,
    );
  }
}
