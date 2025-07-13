import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/textfield/password_textfield.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_mixin.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> with ResetPasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            router.pop<bool>(true);
          },
        ),
      ),
      body: Padding(
        padding: ViewConstants.instance.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LuciText.headlineSmall(
              '${LocaleKeys.reset.tr()}\n${LocaleKeys.password.tr()}',
              fontWeight: FontWeight.bold,
            ),
            verticalBox16,
            PasswordField(labelText: LocaleKeys.newPassword.tr(), passwordController: passwordController),
            verticalBox16,
            PasswordField(
              labelText: LocaleKeys.confirmNewPassword.tr(),
              passwordController: confirmPasswordController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
          text: LocaleKeys.submit.tr(),
          onPressed:  (){},
        ),
    );
  }
}
