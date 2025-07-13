import 'package:flutter/material.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_password_view.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_passwprd_viewmodel.dart';

mixin ForgotPasswordMixin on State<ForgotPasswordView> {
  late final ForgotPasswordViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = ForgotPasswordViewmodel();
    viewmodel.formKey = GlobalKey<FormState>();
    viewmodel.emailController = TextEditingController();
    viewmodel.phoneController = TextEditingController();
  }

  @override
  void dispose() {
    viewmodel.emailController.dispose();
    viewmodel.phoneController.dispose();
    super.dispose();
  }
}
