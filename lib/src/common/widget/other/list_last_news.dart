import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/enums/bookmark_state.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/other/last_news.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

final class ListLastestNews extends StatelessWidget {
  const ListLastestNews({required this.newsList, super.key, this.onRefresh});

  final List<Article> newsList;
  final Future<void> Function(Article article, BookmarkState bookmarkedState)?
  onRefresh;

  @override
  Widget build(BuildContext context) {
    BookmarkState? bookmarkedState;
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
                    bookmarkedState = await router.pushNamed<BookmarkState>(
                      RoutePaths.newsDetail.name,
                      extra: news,
                    );
                    if (bookmarkedState == null) return;
                    if (bookmarkedState == BookmarkState.nothingChanged) return;
                    if (onRefresh != null) {
                      await onRefresh!.call(news, bookmarkedState!);
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
