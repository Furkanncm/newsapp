import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/textfield/password_textfield.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_mixin.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_viewmodel.dart';

@immutable
final class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> with ResetPasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: _Body(viewmodel: viewmodel),
      bottomNavigationBar: _SubmitButton(viewmodel: viewmodel),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          router.pop<bool>(true);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.viewmodel,
  });

  final ResetPasswordViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ViewConstants.instance.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuciText.headlineSmall(
            '${LocaleKeys.reset.tr()}\n${LocaleKeys.password.tr()}',
            fontWeight: FontWeight.bold,
          ),
          verticalBox16,
          _PasswordForm(viewmodel: viewmodel),
        ],
      ),
    );
  }
}

@immutable
final class _PasswordForm extends StatelessWidget {
  const _PasswordForm({
    required this.viewmodel,
  });

  final ResetPasswordViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewmodel.globalKey,
      onChanged: viewmodel.chechvalidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PasswordField(
            labelText: LocaleKeys.newPassword.tr(),
            passwordController: viewmodel.passwordController,
          ),
          verticalBox16,
          PasswordField(
            labelText: LocaleKeys.confirmNewPassword.tr(),
            passwordController: viewmodel.confirmPasswordController,
            confirmPasswordController: viewmodel.passwordController,
          ),
        ],
      ),
    );
  }
}

@immutable
final class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.viewmodel});

  final ResetPasswordViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return BottomButton(
          text: LocaleKeys.submit.tr(),
          onPressed: viewmodel.isValidate ? viewmodel.submit : null,
        );
      },
    );
  }
}
