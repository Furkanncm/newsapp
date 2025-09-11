import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/string_extensions.dart';
import 'package:newsapp/src/common/widget/other/news_info.dart';
import 'package:newsapp/src/common/widget/other/safe_image_network.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class LastNews extends StatelessWidget {
  const LastNews({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.verticalPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SafeImageNetwork(article: article),
            ),
          ),
          horizontalBox12,
          Expanded(
            child: NewsInfo(
              region: article.source?.name ?? 'Unknown Source',
              title: article.title ?? 'No Title',
              source:
                  article.author?.limitString(limit: 18) ?? 'Unknown Author',
              pastTime: article.publishedAt?.setPastTime ?? 'Unknown',
            ),
          ),
        ],
      ),
    );
  }
}
