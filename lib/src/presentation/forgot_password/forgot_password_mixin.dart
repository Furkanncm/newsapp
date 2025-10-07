import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/dialog/news_app_dialogs.dart';
import 'package:newsapp/src/common/utils/enums/otp_options_enum.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
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
    viewmodel.authRepository = AuthRepository();
  }

  Future<void> onSubmitPressed() async {
    final email = viewmodel.emailController.text;
    if (viewmodel.formKey.currentState?.validate() != true) return;
    final otpModel = OTPModel(otpOptions: OTPOptions.email, otpContent: email);
    await viewmodel
        .resetPasswordWithEmail(otpModel.otpContent)
        .withLoading(context: context);
    if (!mounted) return;
    await NewsAppDialogs.infoDialog(
      context: context,
      title: '${LocaleKeys.check.tr()} ${otpModel.otpOptions.value}',
      content:
          '${otpModel.otpOptions.value.capitalizeFirst} ${LocaleKeys.sentTo.tr()} ${otpModel.otpContent}',
    );
    router.goNamed(RoutePaths.login.name);
  }

  @override
  void dispose() {
    viewmodel.emailController.dispose();
    super.dispose();
  }
}
