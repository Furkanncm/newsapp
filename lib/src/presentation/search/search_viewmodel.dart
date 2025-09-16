import 'dart:async';

import 'package:codegen/model/article_model/article_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

part 'search_viewmodel.g.dart';

class SearchViewmodel = _SearchViewmodelBase with _$SearchViewmodel;

abstract class _SearchViewmodelBase with Store {
  late final INewsRepository newsRepository;

  @observable
  int lastestIndex = 0;

  @observable
  List<Article> allNews = [];

  @observable
  List<Article> filteredNews = [];

  Timer? debounce;

  @action
  void changeIndex(int index) => lastestIndex = index;

  @action
  void setNews(List<Article> news) {
    allNews = news;
    filteredNews = news;
  }

  @action
  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        filteredNews = allNews;
      } else {
        filteredNews = allNews
            .where(
              (article) =>
                  article.title?.toLowerCase().contains(value.toLowerCase()) ??
                  false,
            )
            .toList();
      }
    });
  }
}
