import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class LabelWithStar extends StatelessWidget {
  const LabelWithStar({required this.text, this.isRequired = false, super.key});
  final String text;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        children: [
          TextSpan(
            text: isRequired ? ' *' : '',
            style: const TextStyle(color: AppTheme.errorColor),
          ),
        ],
      ),
    );
  }
}
