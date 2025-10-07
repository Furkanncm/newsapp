import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_view.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_viewmodel.dart';

mixin ResetPasswordMixin on State<ResetPasswordView> {
  late final ResetPasswordViewmodel viewmodel;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final GlobalKey<FormState> globalKey;
  late final String email;

  @override
  void initState() {
    super.initState();
    viewmodel = ResetPasswordViewmodel();
    viewmodel.authRepository = AuthRepository();
    viewmodel.globalKey = GlobalKey();
    globalKey = viewmodel.globalKey;
    viewmodel.passwordController = TextEditingController();
    viewmodel.confirmPasswordController = TextEditingController();
    passwordController = viewmodel.passwordController;
    confirmPasswordController = viewmodel.confirmPasswordController;

    email = GoRouter.of(context).state.extra! as String;
  }

  Future<void> onSubmitPressed() async => viewmodel.submit(email);

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
