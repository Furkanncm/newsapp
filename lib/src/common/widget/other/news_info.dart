import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/source_and_ago.dart';

@immutable
final class NewsInfo extends StatelessWidget {
  const NewsInfo({
    required this.region,
    required this.title,
    required this.source,
    required this.pastTime,
    super.key,
  });

  // final Source source;
  final String region;
  final String title;
  final String source;
  final String pastTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LuciText.bodyMedium(region, textColor: AppTheme.bodyText),
        verticalBox4,
        LuciText.bodyLarge(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
        ),
        verticalBox4,
        // source paslanıcak
        SourceAndAgoWidget(source: source, pastTime: pastTime),
      ],
    );
  }
}
