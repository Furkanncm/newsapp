import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/widget/textfield/label_textfield.dart';

@immutable
final class BioTextField extends StatelessWidget {
  const BioTextField({required this.controller, required this.bio, super.key});

  final TextEditingController controller;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return LabelTextField(
      maxLines: 5,
      label: LocaleKeys.bio.tr(),
      prefixIcon: const Icon(Icons.text_snippet_outlined),
      controller: controller,
      userInfo: bio,
    );
  }
}
