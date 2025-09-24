import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_view.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_viewmodel.dart';

mixin SignUpMixin on State<SignUpView> {
  late final SignUpViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SignUpViewmodel();
    viewModel.formKey = GlobalKey<FormState>();
    viewModel.emailController = TextEditingController();
    viewModel.passwordController = TextEditingController();
    viewModel.confirmPasswordController = TextEditingController();
    viewModel.authRepository = AuthRepository();
    viewModel.userRepository = UserRepository();
  }

  bool get isFormValid => viewModel.isFormValid;
  bool get rememberMe => viewModel.isRememberMe;

  void toggleRememberMe() => viewModel.toggleRememberMe();

  Future<void> register() async {
    viewModel.validateForm();
    if (isFormValid) {
      await viewModel.register().withToast(
        context,
        successMessage: LocaleKeys.welcome_sincere.tr(),
        onSuccess: () async => router.goNamed(RoutePaths.topics.name),
      );
    }
  }

  @override
  void dispose() {
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
    viewModel.confirmPasswordController.dispose();
    super.dispose();
  }
}
