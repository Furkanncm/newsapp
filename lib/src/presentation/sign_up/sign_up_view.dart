import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/centered_button.dart';
import 'package:newsapp/src/common/widget/button/social_media_button.dart';
import 'package:newsapp/src/common/widget/form/email_password_form.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/common/widget/text/fadded_text.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_mixin.dart';

@immutable
final class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with SignUpMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: NaPadding.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalBox64,
                LuciText.headlineLarge(
                  LocaleKeys.hello.tr(),
                  fontWeight: FontWeight.bold,
                  textColor: AppTheme.primaryColor,
                ),
                verticalBox8,
                FaddedText(text: LocaleKeys.signUpToGetStarted.tr()),
                verticalBox24,
                EmailPasswordForm(
                  emailController: viewModel.emailController,
                  passwordController: viewModel.passwordController,
                  confirmPasswordController:
                      viewModel.confirmPasswordController,
                  formKey: viewModel.formKey,
                ),
                verticalBox48,
                _SignUpButton(onPressed: register),
                verticalBox32,
                const SocialMediaLogin(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: NaPadding.verticalHighPadding,
        child: _AlreadyHaveAccount(),
      ),
    );
  }
}

@immutable
final class _SignUpButton extends StatelessWidget {
  const _SignUpButton({required this.onPressed});

  final Future<void> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CenteredButton(text: LocaleKeys.signUp.tr(), onPressed: onPressed);
  }
}

@immutable
final class _AlreadyHaveAccount extends StatelessWidget {
  const _AlreadyHaveAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LuciText.bodyMedium(
          LocaleKeys.alreadyHaveAnAccount.tr(),
          textColor: AppTheme.placeholder,
        ),
        GestureDetector(
          onTap: () => router.goNamed(RoutePaths.login.name),
          child: LuciText.bodyMedium(
            LocaleKeys.login.tr(),
            textColor: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}
