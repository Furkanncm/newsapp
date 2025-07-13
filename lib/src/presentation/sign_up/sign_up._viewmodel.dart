import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'sign_up._viewmodel.g.dart';

class SignUpViewmodel = _SignUpViewmodelBase with _$SignUpViewmodel;

abstract class _SignUpViewmodelBase with Store {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @computed
  bool get isFormValid => formKey.currentState?.validate() ?? false;

  @observable
  bool isRememberMe = false;

  @observable
  bool isLoading = false;

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
}
