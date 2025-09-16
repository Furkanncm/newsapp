import 'dart:async';

import 'package:codegen/codegen.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/enums/filter_language_enum.dart';
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


  Future<void> getOnlyFilterCountries() async {
    allCountries = await countryRepository.getCountries();

    onlyFilterCountries.clear();

    for (final country in allCountries) {
      if (FilterLanguageEnum.values.any(
        (e) => e.name.toLowerCase() == country.code?.toLowerCase(),
      )) {
        onlyFilterCountries.add(country);
      }
    }
    print(onlyFilterCountries.length);
  }
}
