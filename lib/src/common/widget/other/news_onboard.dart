import 'package:codegen/model/article_model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/string_extensions.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/other/news_info.dart';
import 'package:newsapp/src/common/widget/other/safe_image_network.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

@immutable
final class TrendNewsOnboard extends StatelessWidget {
  TrendNewsOnboard({required this.article, super.key});

  final Article article;
  final INewsRepository newsRepository = NewsRepository();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await router.pushNamed<bool>(
          RoutePaths.newsDetail.name,
          extra: article,
        );
        await newsRepository.refreshArticles(article, result ?? false);
      },
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: context.height * 0.18,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: SafeImageNetwork(article: article),
            ),
          ),
          verticalBox4,
          NewsInfo(
            region: article.author ?? 'Unknown',
            title: article.title ?? 'Unknown',
            source: article.source?.name ?? 'Unknown',
            pastTime: article.publishedAt?.setPastTime ?? 'Unknown',
          ),
        ],
      ),
    );
  }
}
