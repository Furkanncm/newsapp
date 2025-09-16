import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/other/last_news.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

final class ListLastestNews extends StatelessWidget {
  const ListLastestNews({required this.newsList, super.key, this.onRefresh});

  final List<Article> newsList;
  final Future<void> Function(Article article, bool? isBookmarked)? onRefresh;
  

  @override
  Widget build(BuildContext context) {
    bool? result;
    return Expanded(
      child: newsList.isEmpty
          ? Center(child: LuciText.bodyLarge('No news found'))
          : ListView.builder(
              padding: NaPadding.zeroPadding,
              itemCount: newsList.length,
              itemBuilder: (BuildContext context, int index) {
                final news = newsList[index];
                return GestureDetector(
                  onTap: () async {
                    result = await router.pushNamed<bool>(
                      RoutePaths.newsDetail.name,
                      extra: news,
                    );
                    if (onRefresh != null) {
                      await onRefresh!.call(news, result);
                    }
                  },
                  child: Material(
                    type: MaterialType.transparency,
                    child: LastNews(article: news),
                  ),
                );
              },
            ),
    );
  }
}
