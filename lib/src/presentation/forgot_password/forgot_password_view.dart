import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/common/widget/textfield/email_textfield_with_label.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_password_mixin.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_passwprd_viewmodel.dart';

@immutable
final class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with ForgotPasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: router.pop,
        ),
      ),
      body: _Body(viewmodel: viewmodel),
      bottomNavigationBar: _SubmitButton(onSubmit: onSubmitPressed),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({required this.viewmodel});

  final ForgotPasswordViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuciText.headlineSmall(
            LocaleKeys.forgotPasswordTitle.tr(),
            fontWeight: FontWeight.bold,
          ),
          verticalBox16,
          LuciText.bodyLarge(
            LocaleKeys.forgotPasswordSubtitle.tr(),
            textColor: AppTheme.bodyText,
          ),
          verticalBox32,
          Form(
            key: viewmodel.formKey,
            child: _TextFields(emailController: viewmodel.emailController),
          ),
        ],
      ),
    );
  }
}

@immutable
final class _TextFields extends StatelessWidget {
  const _TextFields({required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return EmailFieldWithLabel(
      emailController: emailController,
      isForVerify: false,
    );
  }
}

@immutable
final class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return NewsBottomButton(
      text: LocaleKeys.submit.tr(),
      onPressed: onSubmit.call,
    );
  }
}
