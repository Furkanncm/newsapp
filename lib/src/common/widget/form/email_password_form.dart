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
    this.confirmPasswordController,
    this.onChanged,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: onChanged,
      key: formKey,
      child: Column(
        children: [
          EmailFieldWithLabel(emailController: emailController),
          verticalBox16,
          PasswordField(
            labelText: LocaleKeys.password.tr(),
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),
        ],
      ),
    );
  }
}
