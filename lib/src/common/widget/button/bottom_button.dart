import 'package:flutter/material.dart';
import 'package:lucielle/utils/utils.dart';
import 'package:lucielle/widget/button/elevated_button.dart';
import 'package:lucielle/widget/text/luci_text.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class NewsBottomButton extends StatelessWidget {
  const NewsBottomButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: NaPadding.zeroPadding,
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
        color: AppTheme.buttonBackground,
        child: SafeArea(
          child: Padding(
            padding: NaPadding.mainButtonPadding,
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
