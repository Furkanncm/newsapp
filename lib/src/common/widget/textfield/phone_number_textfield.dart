import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';

@immutable
final class PhoneNumberTextfield extends StatelessWidget {
  const PhoneNumberTextfield({required this.phoneController, super.key});

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar(isRequired: true, text: LocaleKeys.phoneNumber.tr()),
        verticalBox4,
        LuciPhoneTextFormField(labelText: '', controller: phoneController),
      ],
    );
  }
}
