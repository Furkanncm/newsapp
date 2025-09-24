import 'package:codegen/codegen.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/common/utils/enums/query_params.dart';
import 'package:newsapp/src/common/utils/enums/remote_ds_path.dart';
import 'package:newsapp/src/data/data_source/remote/news_api_ds.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/firebase_firestore/firebase_firestore_repository.dart';

abstract class INewsRepository {
  Future<List<Article>> fetchNews();
  Future<void> saveNews(Article article, bool isBookmarked);
  Future<void> refreshArticles(Article article, bool isBookmarked);
  Future<News?> fetchTrendingNews();
  Future<News?> fetchNewsWithFilters({
    Topic? topic,
    FilterShortByEnum? shortBy,
    Country? country,
  });
  Country? get selectedCountry;
}

final class NewsRepository implements INewsRepository {
  factory NewsRepository() {
    return _instance ??= NewsRepository._internal();
  }

  NewsRepository._internal() {
    _firestoreRepository = FirebaseFirestoreRepository();
    _countryRepository = CountryRepository();
  }

  static NewsRepository? _instance;

  late final IFirebaseFirestoreRepository _firestoreRepository;
  late final ICountryRepository _countryRepository;

  @override
  Country? get selectedCountry => _countryRepository.selectedCountry;

  @override
  Future<List<Article>> fetchNews() async => _firestoreRepository.getNews();

  @override
  Future<void> saveNews(Article article, bool isBookmarked) async {
    await fetchNews();
    if (isBookmarked) {
      await _firestoreRepository.removeNews(article);
    } else {
      await _firestoreRepository.saveNews(article);
    }
  }

  @override
  Future<void> refreshArticles(Article article, bool isBookmarked) async =>
      saveNews(article, !isBookmarked);

  @override
  Future<News?> fetchTrendingNews() async {
    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: {QueryParams.country.name: 'us'},
    );
    if (!(data.succeeded ?? false)) return null;

    return data.data;
  }

  @override
  Future<News?> fetchNewsWithFilters({
    Topic? topic,
    FilterShortByEnum? shortBy,
    Country? country,
  }) async {
    final countryCode = country?.code?.toLowerCase() ?? 'us';
    final params = <String, dynamic>{QueryParams.country.name: countryCode};

    if (topic?.value?.isNotEmpty ?? false) {
      params[QueryParams.category.name] = topic!.value;
    }

    if (shortBy?.name.isNotEmpty ?? false) {
      params[QueryParams.sortBy.name] = shortBy!.name;
    }

    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: params,
    );

    if (!(data.succeeded ?? false)) return null;
    return data.data;
  }
}
