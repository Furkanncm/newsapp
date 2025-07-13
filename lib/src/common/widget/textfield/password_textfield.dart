import 'package:flutter/widgets.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:lucielle/widget/textfield/password_field.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class PasswordField extends StatelessWidget {
  const PasswordField({
    required this.passwordController,
    this.labelText = 'Password',
    super.key,
  });

  final TextEditingController passwordController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: labelText,
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ],
          ),
        ),
        verticalBox4,
        LuciPasswordTextFormField(
          controller: passwordController,
          labelText: '',
        ),
      ],
    );
  }
}
