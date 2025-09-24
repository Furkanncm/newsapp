import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/common/widget/textfield/email_texfield.dart';

@immutable
final class EmailFieldWithLabel extends StatefulWidget {
  const EmailFieldWithLabel({required this.emailController, this.readOnly =false, super.key});

  final TextEditingController emailController;
  final bool readOnly;

  @override
  State<EmailFieldWithLabel> createState() => _EmailFieldWithLabelState();
}

class _EmailFieldWithLabelState extends State<EmailFieldWithLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar(isRequired: true, text: LocaleKeys.email.tr()),
        verticalBox4,
        EmailTextField(
          emailController: widget.emailController,
          readOnly: widget.readOnly,
        ),
      ],
    );
  }
}
