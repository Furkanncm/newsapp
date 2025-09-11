import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';

part 'sign_up_viewmodel.g.dart';

class SignUpViewmodel = _SignUpViewmodelBase with _$SignUpViewmodel;

abstract class _SignUpViewmodelBase with Store {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final IFirebaseDataSource _firebaseDataSource = FirebaseDataSource.instance;

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

    final response = await _firebaseDataSource.register(
      email: emailController.text,
      password: passwordController.text,
      isRememberMe: isRememberMe,
    );

    isLoading = false;  
    registrationResponse = response;
    if (response.data == true && response.succeeded == true) {
      isSuccess = true;
      resetForm();
      return NetworkResponse.success(data: response.succeeded??false);
    } else {
      isSuccess = false;
      return NetworkResponse.failure(message: 'Registration failed');
    }
  }
}
