import 'dart:async';

import 'package:codegen/codegen.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/data/model/filter/filter.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

part 'search_viewmodel.g.dart';

class SearchViewmodel = _SearchViewmodelBase with _$SearchViewmodel;

abstract class _SearchViewmodelBase with Store {
  late final INewsRepository newsRepository;
  late final ICountryRepository countryRepository;

  @observable
  int lastestIndex = 0;

  @observable
  List<Article> allNews = [];

  @observable
  List<Article> filteredNews = [];

  List<Country> allCountries = [];

  List<Country> onlyFilterCountries = [];

  Timer? debounce;

  @observable
  Filter filters = Filter(
    shortBy: [FilterShortByEnum.publishedAt],
    language: [
      const Country(
        name: 'United States',
        code: 'US',
        phoneCode: '+1',
        flag: 'https://flagcdn.com/w40/us.png',
        isSelected: false,
      ),
    ],
    topic: [],
  );

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
    debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.isEmpty) {
        filteredNews = allNews;
      } else {
        final filter = Filter(
          shortBy: filters.shortBy,
          language: filters.language,
          topic: filters.topic,
        );
        final response = await newsRepository.fetchNewsWithFilters(
          filter: filter,
          query: value,
        );

        if (response == null) return;
        if (response.articles == null) return;
        filteredNews = response.articles!
            .where(
              (article) =>
                  article.title?.toLowerCase().contains(value.toLowerCase()) ??
                  false,
            )
            .toList();
      }
    });
  }

  @action
  void getOnlyFilterCountries() {
    final list = countryRepository.onlyFilterCountries;
    onlyFilterCountries = ObservableList.of(list);
  }

  @action
  Future<void> setFilters(Filter? newFilters, String? value) async {
    if (value == null) filteredNews = allNews;
    final filter = Filter(
      shortBy: filters.shortBy,
      language: filters.language,
      topic: filters.topic,
    );

    final filterNews = await newsRepository.fetchNewsWithFilters(
      query: value,
      filter: filter,
    );

    setNews(filterNews?.articles ?? allNews);
  }
}
