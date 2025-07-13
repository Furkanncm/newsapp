import 'package:flutter/material.dart';
import 'package:lucielle/utils/utils.dart';
import 'package:lucielle/widget/button/elevated_button.dart';
import 'package:lucielle/widget/text/luci_text.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class BottomButton extends StatelessWidget {
  const BottomButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.placeholder,
            width: 0.6,
          ),
        ),
      ),
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        shape: LinearBorder.bottom(),
        elevation: 3,
        color: AppTheme.surfaceColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: context.height * .06,
              child: LuciElevatedButton(
                backgroundColor: AppTheme.primaryColor,
                onPressed: onPressed,
                child: LuciText.labelMedium(text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
