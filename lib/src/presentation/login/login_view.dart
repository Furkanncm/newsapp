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
import 'package:newsapp/src/presentation/login/login_mixin.dart';
import 'package:newsapp/src/presentation/login/login_viewmodel.dart';

@immutable
final class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: ViewConstants.instance.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Headline(),
                verticalBox24,
                EmailPasswordForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: formKey,
                ),
                verticalBox4,
                _RememberMe(viewmodel: viewModel),
                verticalBox12,
                _LoginButton(isFormValid: isFormValid),
                verticalBox16,
                const SocialMediaLogin(),
                verticalBox24,
                const _DontHaveAccount(),
                verticalBox64,
                verticalBox64,
                verticalBox32,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
final class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LuciText.headlineLarge(
          LocaleKeys.hello.tr(),
          fontWeight: FontWeight.bold,
        ),
        LuciText.headlineLarge(
          LocaleKeys.again.tr(),
          fontWeight: FontWeight.bold,
          textColor: AppTheme.primaryColor,
        ),
        verticalBox8,
        FaddedText(text: LocaleKeys.welcomeBack.tr()),
        FaddedText(text: LocaleKeys.beenMissed.tr()),
      ],
    );
  }
}

@immutable
final class _RememberMe extends StatelessWidget {
  const _RememberMe({
    required this.viewmodel,
  });

  final LoginViewmodel viewmodel;
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
          textColor: AppTheme.bodyText,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => router.pushNamed(RoutePaths.forgotPassword.name),
          child: LuciText.bodyMedium(
            LocaleKeys.forgotPassword.tr(),
            textColor: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}

@immutable
final class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.isFormValid,
  });

  final bool isFormValid;

  @override
  Widget build(BuildContext context) {
    return CenteredButton(
      text: LocaleKeys.login.tr(),
      onPressed: () => router.goNamed(RoutePaths.signUp.name),
    );
  }
}

@immutable
final class _DontHaveAccount extends StatelessWidget {
  const _DontHaveAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LuciText.bodyMedium(
          LocaleKeys.dontHaveAccount.tr(),
          textColor: AppTheme.placeholder,
        ),
        GestureDetector(
          onTap: () => router.goNamed(RoutePaths.signUp.name),
          child: LuciText.bodyMedium(
            LocaleKeys.signUp.tr(),
            textColor: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}
