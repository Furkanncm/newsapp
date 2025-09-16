import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/home/home_view.dart';
import 'package:newsapp/src/presentation/home/home_viewmodel.dart';

mixin HomeMixin on State<HomeView> {
  late final HomeViewmodel viewmodel;
  late final TextEditingController controller;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    viewmodel = HomeViewmodel();
    viewmodel.userRepository = UserRepository();
    viewmodel.newsRepository = NewsRepository();
    controller = TextEditingController();
    user = viewmodel.userRepository.currentUser;
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
