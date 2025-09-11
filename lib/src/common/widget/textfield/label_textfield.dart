import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/common/widget/textfield/news_app_textfield.dart';

@immutable
final class LabelTextField extends StatelessWidget {
  const LabelTextField({
    required this.label,
    required this.controller,
    required this.userInfo,
    this.onTap,
    this.prefixIcon,
    this.maxLines = 1,
    super.key,
  });

  final String label;
  final String userInfo;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final int maxLines;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    controller.text = userInfo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar(text: label),
        verticalBox4,
        NewsAppTextField(
          readOnly: onTap != null,
          onTap: onTap,
          controller: controller,
          maxLines: maxLines,
          prefixIcon: prefixIcon,
        ),
      ],
    );
  }
}
