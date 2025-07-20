import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class LabelWithStar extends StatelessWidget {
  const LabelWithStar({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        children: const [
          TextSpan(
            text: '*',
            style: TextStyle(color: AppTheme.errorColor),
          ),
        ],
      ),
    );
  }
}
