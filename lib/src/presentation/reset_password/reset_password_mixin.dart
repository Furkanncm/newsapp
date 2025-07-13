import 'package:flutter/material.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_view.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_viewmodel.dart';

mixin ResetPasswordMixin on State<ResetPasswordView> {
  late final ResetPasswordViewmodel viewmodel;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;



  @override
  void initState() {
    super.initState();
    viewmodel = ResetPasswordViewmodel();
    viewmodel.passwordController = TextEditingController();
    passwordController = viewmodel.passwordController;
    viewmodel.confirmPasswordController = TextEditingController();
    confirmPasswordController = viewmodel.confirmPasswordController;
  }
}
