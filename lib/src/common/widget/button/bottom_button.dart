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
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        shape: LinearBorder.bottom(),
        elevation: 3,
        color: Colors.grey[200],
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
