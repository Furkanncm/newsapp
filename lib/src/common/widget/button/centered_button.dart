import 'package:flutter/material.dart';
import 'package:lucielle/utils/utils.dart';
import 'package:lucielle/widget/button/elevated_button.dart';
import 'package:lucielle/widget/text/luci_text.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class CenteredButton extends StatefulWidget {
  const CenteredButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final Future<void> Function()? onPressed;

  @override
  State<CenteredButton> createState() => _CenteredButtonState();
}

class _CenteredButtonState extends State<CenteredButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.height * .06,
      child: LuciElevatedButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: isLoading
            ? null
            : () async {
                if (widget.onPressed != null) {
                  setState(() => isLoading = true);
                  try {
                    await widget.onPressed!();
                  } finally {
                    if (mounted) setState(() => isLoading = false);
                  }
                }
              },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppTheme.buttonBackground,
                ),
              )
            : LuciText.labelMedium(widget.text),
      ),
    );
  }
}
