import 'package:flutter/material.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up._viewmodel.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_view.dart';

mixin SignUpMixin on State<SignUpView> {
  late final SignUpViewmodel viewModel;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    viewModel = SignUpViewmodel();
    formKey = viewModel.formKey;
    emailController = viewModel.emailController;
    passwordController = viewModel.passwordController;
  }
  
  bool get isFormValid => viewModel.isFormValid;
  bool get rememberMe => viewModel.isRememberMe;

  void toggleRememberMe() => viewModel.toggleRememberMe();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

}
