import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/common/widget/textfield/news_app_textfield.dart';

@immutable
final class LabelTextField extends StatelessWidget {
  const LabelTextField({required this.label, required this.controller, this.prefixIcon, super.key});

  final String label;
  final Widget? prefixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar(text: label),
        verticalBox4,
        NewsAppTextField(prefixIcon: prefixIcon),
      ],
    );
  }
}
