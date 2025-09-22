import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:lucielle/widget/textfield/password_field.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';

@immutable
final class PasswordField extends StatelessWidget {
  const PasswordField({
    required this.passwordController,
    this.confirmPasswordController,
    this.labelText = 'Password',
    super.key,
  });

  final TextEditingController passwordController;
  final TextEditingController? confirmPasswordController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar(isRequired: true, text: labelText),
        verticalBox4,
        LuciPasswordTextFormField(
          controller: passwordController,
          confirmController: confirmPasswordController,
          labelText: '',
        ),
        verticalBox16,
        Visibility(
          visible: confirmPasswordController != null,
          replacement: emptyBox,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelWithStar(
                isRequired: true,
                text: LocaleKeys.confirmPassword.tr(),
              ),
              verticalBox4,
              LuciPasswordTextFormField(
                controller: confirmPasswordController,
                confirmController: passwordController,
                labelText: '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
