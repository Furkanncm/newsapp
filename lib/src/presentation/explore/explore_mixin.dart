import 'package:flutter/material.dart';
import 'package:newsapp/src/presentation/explore/explore_view.dart';
import 'package:newsapp/src/presentation/explore/explore_viewmodel.dart';

mixin ExploreMixin on State<ExploreView> {

  late final ExploreViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = ExploreViewmodel();
    viewmodel.fetchTrendingNews();
  }
}