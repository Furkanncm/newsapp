import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/common/widget/textfield/news_app_textfield.dart';

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel({
    required this.label,
    required this.isRequired,
    super.key,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.textAlign,
    this.autovalidateMode,
    this.validator,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.prefixIcon,
    this.labelText,
    this.maxLength,
    this.suffixIcon,
    this.enabled,
    this.focusNode,
    this.fillColor,
    this.hintText,
  });

  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextAlign? textAlign;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool? enabled;
  final FocusNode? focusNode;
  final Color? fillColor;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar( isRequired: isRequired, text: label),
        verticalBox4,
        NewsAppTextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          textAlign: textAlign,
          autovalidateMode: autovalidateMode,
          validator: isRequired ? validator : null,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          prefixIcon: prefixIcon,
          hintText: hintText,
          labelText: labelText,
          maxLength: maxLength,
          suffixIcon: suffixIcon,
          enabled: enabled,
          focusNode: focusNode,
          fillColor: fillColor,
        ),
      ],
    );
  }
}
