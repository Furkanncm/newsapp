import 'package:flutter/material.dart';
import 'package:lucielle/utils/utils.dart';
import 'package:lucielle/widget/button/elevated_button.dart';
import 'package:lucielle/widget/text/luci_text.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class CenteredButton extends StatelessWidget {
  const CenteredButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.height * .06,
      child: LuciElevatedButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: onPressed,
        child: LuciText.labelMedium(text),
      ),
    );
  }
}
