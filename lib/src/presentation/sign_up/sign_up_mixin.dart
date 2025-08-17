import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/enums/snackbar_enum.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/snackbar/snackbar.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_view.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_viewmodel.dart';

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

  Future<void> register() async {
    viewModel.validateForm();
    if (isFormValid) {
      await viewModel.register();
      if (viewModel.isSuccess == true) {
        NewsAppSnackBar.show(
          context: context,
          text: LocaleKeys.registrationSuccess.tr(),
          type: SnackBarType.info,
        );
        router.goNamed(RoutePaths.topics.name);
      } else {
        NewsAppSnackBar.show(
          context: context,
          text:
              viewModel.registrationResponse?.messages?.first ??
              LocaleKeys.registrationFail.tr(),
          type: SnackBarType.warning,
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
