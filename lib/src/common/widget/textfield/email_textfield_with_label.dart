import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/textfield/email_texfield.dart';

@immutable
final class EmailFieldWithLabel extends StatefulWidget {
  const EmailFieldWithLabel({
    required this.emailController,
    super.key,
  });

  final TextEditingController emailController;

  @override
  State<EmailFieldWithLabel> createState() => _EmailFieldWithLabelState();
}

class _EmailFieldWithLabelState extends State<EmailFieldWithLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: LocaleKeys.email.tr(),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ],
          ),
        ),
        verticalBox4,
        EmailTextField(emailController: widget.emailController),
      ],
    );
  }
}
