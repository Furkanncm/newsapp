import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/widget/textfield/email_textfield_with_label.dart';
import 'package:newsapp/src/common/widget/textfield/password_textfield.dart';

class EmailPasswordForm extends StatelessWidget {
  const EmailPasswordForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          EmailFieldWithLabel(emailController: emailController),
          verticalBox16,
          PasswordField(
            passwordController: passwordController,
            labelText: LocaleKeys.password.tr(),
          ),
        ],
      ),
    );
  }
}
