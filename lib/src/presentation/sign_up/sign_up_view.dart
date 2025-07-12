// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/centered_button.dart';
import 'package:newsapp/src/common/widget/button/social_media_button.dart';
import 'package:newsapp/src/common/widget/form/email_password_form.dart';
import 'package:newsapp/src/common/widget/text/fadded_text.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up._viewmodel.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: ViewConstants.instance.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalBox48,
              LuciText.headlineLarge(
                LocaleKeys.hello.tr(),
                fontWeight: FontWeight.bold,
                textColor: AppTheme.primaryColor,
              ),
              verticalBox8,
              FaddedText(text: LocaleKeys.signUpToGetStarted.tr()),
              verticalBox48,
              EmailPasswordForm(
                emailController: emailController,
                passwordController: passwordController,
                formKey: formKey,
              ),
              verticalBox4,
              _RememberMe(viewmodel: viewModel),
              verticalBox16,
              const _SignUpButton(),
              verticalBox16,
              const SocialMediaLogin(),
              verticalBox16,
              const _AlreadyHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _RememberMe extends StatelessWidget {
  const _RememberMe({
    required this.viewmodel,
  });

  final SignUpViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(
          builder: (_) {
            return Checkbox(
              value: viewmodel.isRememberMe,
              onChanged: (value) => viewmodel.toggleRememberMe(),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          },
        ),
        LuciText.bodyMedium(
          LocaleKeys.rememberMe.tr(),
          textColor: AppTheme.textColorLight,
        ),
      ],
    );
  }
}

@immutable
final class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return CenteredButton(
      text: LocaleKeys.signUp.tr(),
      onPressed: () {},
    );
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
          textColor: AppTheme.surfaceDarkColor.withValues(alpha: 0.5),
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
