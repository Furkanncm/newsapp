import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'sign_up_viewmodel.g.dart';

class SignUpViewmodel = _SignUpViewmodelBase with _$SignUpViewmodel;

abstract class _SignUpViewmodelBase with Store {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final IAuthRepository authRepository;
  late final IUserRepository userRepository;

  @computed
  bool get isFormValid => validateForm();

  @observable
  bool isRememberMe = true;

  @observable
  NetworkResponse<bool?>? registrationResponse;

  @observable
  bool isLoading = false;

  @observable
  bool? isSuccess;

  @action
  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
  }

  @action
  void resetForm() {
    formKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
  }

  @action
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  @action
  Future<NetworkResponse<bool>> register() async {
    if (!isFormValid) return NetworkResponse.failure(message: 'Invalid form');

    isLoading = true;

    final response = await authRepository.register(
      email: emailController.text,
      password: passwordController.text,
      isRememberMe: isRememberMe,
    );

    isLoading = false;
    registrationResponse = response;
    if (response.data == true && response.succeeded == true) {
      isSuccess = true;
      await userRepository.getUserInfo();
      resetForm();
      return NetworkResponse.success(data: response.succeeded ?? false);
    } else {
      isSuccess = false;
      return NetworkResponse.failure(message: 'Registration failed');
    }
  }
}
