import 'package:flutter/material.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';
import 'package:newsapp/src/presentation/bookmark/bookmark_view.dart';
import 'package:newsapp/src/presentation/bookmark/bookmark_viewmodel.dart';

mixin BookmarkMixin on State<BookmarkView> {
  late final BookmarkViewModel viewmodel;
    late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    viewmodel = BookmarkViewModel();
    viewmodel.newsRepository = NewsRepository();
    controller = TextEditingController();
    setArticles();
  }

  Future<void> setArticles() async => viewmodel.setArticles();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
