import 'package:flutter/material.dart';

class NewsAppTextField extends StatelessWidget {
  const NewsAppTextField({
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
    this.hintText,
    this.labelText,
    this.maxLength,
    this.suffixIcon,
    this.enabled,
    this.focusNode,
    this.fillColor,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  final TextInputType? keyboardType;

  /// Called when the text is changed.
  final void Function(String)? onChanged;

  /// Aligns the text within the field.
  final TextAlign? textAlign;

  /// Controls whether validation occurs automatically or manually.
  final AutovalidateMode? autovalidateMode;

  final String? Function(String?)? validator;

  /// Called when editing is complete (e.g., on "done").
  final void Function()? onEditingComplete;

  /// Called when the user submits the field.
  final void Function(String)? onFieldSubmitted;

  /// The action button to display on the keyboard.
  final TextInputAction? textInputAction;

  /// A widget to display before the input (e.g., an icon).
  final Widget? prefixIcon;

  /// Placeholder text shown inside the field when it's empty.
  final String? hintText;

  /// The label displayed above the input.
  final String? labelText;

  /// The maximum number of lines the field can have.
  final int? maxLength;

  /// A widget to display after the input (e.g., visibility toggle).
  final Widget? suffixIcon;

  /// Whether the text field is enabled or disabled.
  final bool? enabled;

  /// An optional focus node to control the field's focus state.
  final FocusNode? focusNode;

  /// The background color of the text field.
  /// Defaults to [Colors.white] if not provided.
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      textAlign: textAlign ?? TextAlign.left,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(8),
            left: Radius.circular(8),
          ),
        ),
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
      ).copyWith(filled: true, fillColor: fillColor ?? Colors.white),
      enabled: enabled,
      focusNode: focusNode,
      maxLines: maxLength ?? 1,
    );
  }
}
