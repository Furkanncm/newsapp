import 'package:flutter/widgets.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class FaddedText extends StatelessWidget {
  const FaddedText({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return LuciText.labelSmall(
      text,
      textColor: AppTheme.bodyText,
    );
  }
}
