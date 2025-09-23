import 'package:codegen/model/article_model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/news_app_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/data/model/filter/filter.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';
import 'package:newsapp/src/presentation/search/search_view.dart';
import 'package:newsapp/src/presentation/search/search_viewmodel.dart';

mixin SearchMixin on State<SearchView> {
  late final TextEditingController controller;
  late final SearchViewmodel viewmodel;
  late final List<Article>? newsList;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    viewmodel = SearchViewmodel();
    viewmodel.newsRepository = NewsRepository();
    viewmodel.countryRepository = CountryRepository();
    final list = GoRouter.of(context).state.extra as List<Article>?;
    if (list != null) {
      viewmodel.setNews(list);
    }
    viewmodel.getOnlyFilterCountries();
  }

  Future<void> onFilteredPressed() async {
    final result = await NewsAppBottomSheet.showFilterBottomSheet<Filter>(
      context: context,
      onlyFilterCountries: viewmodel.onlyFilterCountries,
      shortBy: viewmodel.filters.shortBy,
      languages: viewmodel.filters.language,
      topicList: viewmodel.filters.topic,
    );
    if (!mounted) return;

    await viewmodel.setFilters(result).withLoading(context: context);
  }

  @override
  void dispose() {
    viewmodel.debounce?.cancel();
    controller.dispose();
    super.dispose();
  }
}
