import 'package:flutter/material.dart';
import 'package:lucielle/widget/text/luci_text.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

class NewsButton extends StatelessWidget {
  const NewsButton({
    required this.text,
    super.key,
    this.onPressed,
  });
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: NaPadding.elevatedButtonPadding,
      ),
      onPressed: onPressed,
      child: LuciText.labelSmall(
        text,
        textColor: Colors.white,
      ),
    );
  }
}
