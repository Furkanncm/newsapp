import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/widget/textfield/textfield_with_label.dart';

@immutable
final class UserNameTextfield extends StatelessWidget {
  const UserNameTextfield({required this.nameController, super.key});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithLabel(
      label: LocaleKeys.username.tr(),
      prefixIcon: const Icon(Icons.person_2_outlined),
      controller: nameController,
      isRequired: false,
    );
  }
}
