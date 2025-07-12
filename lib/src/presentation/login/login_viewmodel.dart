import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_viewmodel.g.dart';

class LoginViewmodel = _LoginViewmodelBase with _$LoginViewmodel;

abstract class _LoginViewmodelBase with Store {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @observable
  bool isRememberMe = false;

  @observable
  bool isLoading = false;

  @computed
  bool get isFormValid =>formKey.currentState?.validate()??false;
    

  @action
  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
  }


}
