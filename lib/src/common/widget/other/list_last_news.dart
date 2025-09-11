import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/other/last_news.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

class ListLastestNews extends StatelessWidget {
  const ListLastestNews({required this.newsList, super.key});

  final List<Article> newsList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: newsList.isEmpty
          ? Center(child: LuciText.bodyLarge('No news found'))
          : ListView.builder(
              padding: NaPadding.zeroPadding,
              itemCount: newsList.length,
              itemBuilder: (BuildContext context, int index) {
                final news = newsList[index];
                return GestureDetector(
                  onTap: () {
                    router.pushNamed(RoutePaths.newsDetail.name, extra: news);
                  },
                  child: Hero(
                    tag: index,
                    child: Material(
                      type: MaterialType.transparency,
                      child: LastNews(article: news),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
