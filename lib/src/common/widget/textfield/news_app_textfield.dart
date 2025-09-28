import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class NewsAppTextField extends StatelessWidget {
  const NewsAppTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.readOnly,
    this.textAlign,
    this.autovalidateMode,
    this.validator,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputAction,
    this.prefixIcon,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.suffixIcon,
    this.enabled,
    this.focusNode,
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

  final void Function()? onTap;

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
  final int? maxLines;

  /// A widget to display after the input (e.g., visibility toggle).
  final Widget? suffixIcon;

  /// Whether the text field is enabled or disabled.
  final bool? enabled;

  final bool? readOnly;

  /// An optional focus node to control the field's focus state.
  final FocusNode? focusNode;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.left,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
      ).copyWith(filled: true, fillColor: (Theme.brightnessOf(context) == Brightness.light)
          ? AppTheme.surfaceColor
          : AppTheme.bodyText),
      enabled: enabled,
      focusNode: focusNode,
      maxLines: maxLines ?? 1,
      minLines: 1,
    );
  }
}
