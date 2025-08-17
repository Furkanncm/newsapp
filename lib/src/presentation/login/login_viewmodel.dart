import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';

part 'login_viewmodel.g.dart';

class LoginViewmodel = _LoginViewmodelBase with _$LoginViewmodel;

abstract class _LoginViewmodelBase with Store {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseDataSource _firebaseDataSource = FirebaseDataSource.instance;

  @observable
  bool isRememberMe = true;

  @observable
  bool isLoading = false;

  @observable
  bool isFormValid = false;

  @action
  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
  }

  Future<NetworkResponse<bool>?> login() async {
    return _firebaseDataSource.logInWithEmail(
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
