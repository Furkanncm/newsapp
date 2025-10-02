import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'login_viewmodel.g.dart';

class LoginViewmodel = _LoginViewmodelBase with _$LoginViewmodel;

abstract class _LoginViewmodelBase with Store {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final IAuthRepository authRepository;
  late final IUserRepository userRepository;
  late final CacheRepository cacheRepository;

  @observable
  bool isRememberMe = true;

  @observable
  bool isLoading = false;

  @observable
  bool isFormValid = false;



  Future<NetworkResponse<bool>?> login() async {
    return authRepository.logInWithEmail(
      email: emailController.text,
      password: passwordController.text,
      isRememberMe: isRememberMe,
    );
  }

  @action
  void validateForm() {
    isFormValid = formKey.currentState?.validate() ?? false;
  }
}
