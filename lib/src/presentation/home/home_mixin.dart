import 'package:codegen/model/topic/topic.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/home/home_view.dart';
import 'package:newsapp/src/presentation/home/home_viewmodel.dart';

mixin HomeMixin on State<HomeView> {
  late final HomeViewmodel viewmodel;
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();
    viewmodel = HomeViewmodel();
    viewmodel.userRepository = UserRepository();
    viewmodel.newsRepository = NewsRepository();
    controller = TextEditingController();
    viewmodel
      ..fetchTrendingNews()
      ..fetchNewsForCategory(Topic.allTopics.first);
    viewmodel.newsRepository.fetchNews();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
