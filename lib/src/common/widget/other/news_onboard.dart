import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/bookmark_state.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/bookmarked_extensions.dart';
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
        final bookmarkedState = await router.pushNamed<BookmarkState>(
          RoutePaths.newsDetail.name,
          extra: article,
        );
        if (bookmarkedState == null) return;
        if (bookmarkedState == BookmarkState.nothingChanged) return;
        await newsRepository.refreshArticles(
          article,
          bookmarkedState.toBool() ?? false,
        );
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
            region: article.author ?? LocaleKeys.unknown.tr(),
            title: article.title ?? LocaleKeys.unknown.tr(),
            source: article.source?.name ?? LocaleKeys.unknown.tr(),
            pastTime:
                article.publishedAt?.setPastTime ?? LocaleKeys.unknown.tr(),
          ),
        ],
      ),
    );
  }
}
