import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/other/last_news.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';

class ListLastestNews extends StatelessWidget {
  const ListLastestNews({super.key});

  // final List<News> newsList

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: NaPadding.zeroPadding,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              router.pushNamed(
                RoutePaths.newsDetail.name,
                extra: Article(
                  source: const Source(id: '1', name: 'BBC News'),
                  author: 'BBC News',
                  title:
                      "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
                  description:
                      "Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of earning their money in other people's blood.",
                  url: 'https://thumbs.dreamstime.com/b/news-woodn-dice-depicting-letters-bundle-small-newspapers-leaning-left-dice-34802664.jpg',
                  publishedAt: '19.10.2025',
                  content:
                      "Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of earning their money in other people's blood. In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn (326bn) this year",
                ),
              );
            },
            child: const LastNews(),
          );
        },
      ),
    );
  }
}
