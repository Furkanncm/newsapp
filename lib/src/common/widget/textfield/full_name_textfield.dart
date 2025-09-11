import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/widget/textfield/textfield_with_label.dart';

@immutable
final class FullNameTextfield extends StatelessWidget {
  const FullNameTextfield({required this.fullNameController, super.key});

  final TextEditingController fullNameController;
  @override
  Widget build(BuildContext context) {
    return TextFieldWithLabel(
      label: LocaleKeys.fullName.tr(),
      prefixIcon: const Icon(Icons.person_outline_outlined),
      controller: fullNameController,
      isRequired: false,
    );
  }
}
