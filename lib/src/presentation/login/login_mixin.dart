import 'package:flutter/widgets.dart';
import 'package:newsapp/src/presentation/login/login_view.dart';
import 'package:newsapp/src/presentation/login/login_viewmodel.dart';

mixin LoginMixin on State<LoginView> {
  late final LoginViewmodel viewModel;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewmodel();
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
