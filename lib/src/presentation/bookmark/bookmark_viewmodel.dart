import 'dart:async';

import 'package:codegen/model/article_model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

part 'bookmark_viewmodel.g.dart';

class BookmarkViewModel = _Base with _$BookmarkViewModel;

abstract class _Base with Store {
  late final INewsRepository newsRepository;
  late final TextEditingController controller;

  @observable
  List<Article> articles = [];

  @observable
  bool isLoading = false;

  @observable
  List<Article> filteredNews = [];

  Timer? debounce;

  @action
  Future<void> setArticles() async {
    changeLoading();
    articles = await newsRepository.fetchNews();
    filteredNews = articles;
    changeLoading();
  }

  @action
  Future<void> refreshArticles(Article article, bool isBookmarked) async {
    await newsRepository.refreshArticles(article, isBookmarked);

    await setArticles();
  }

  @action
  void changeLoading() => isLoading = !isLoading;

  @action
  void onSearchChanged(String value) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        filteredNews = articles;
      } else {
        filteredNews = articles
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
