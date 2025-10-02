import 'package:codegen/codegen.dart';
import 'package:newsapp/src/common/utils/enums/query_params.dart';
import 'package:newsapp/src/common/utils/enums/remote_ds_path.dart';
import 'package:newsapp/src/data/data_source/remote/news_api_ds.dart';
import 'package:newsapp/src/data/model/filter/filter.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/firestore/firestore_repository.dart';

abstract class INewsRepository {
  Future<List<Article>> fetchNews();
  Future<void> saveNews(Article article, bool isBookmarked);
  Future<void> refreshArticles(Article article, bool isBookmarked);
  Future<News?> fetchTrendingNews();
  Future<News?> fetchNewsWithFilters({Filter? filter, String? query});
  Country? get selectedCountry;
}

final class NewsRepository implements INewsRepository {
  factory NewsRepository() {
    return _instance ??= NewsRepository._internal();
  }

  NewsRepository._internal() {
    _firestoreRepository = FirestoreRepository();
    _countryRepository = CountryRepository();
  }

  static NewsRepository? _instance;

  late final IFirestoreRepository _firestoreRepository;
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
  Future<News?> fetchNewsWithFilters({Filter? filter, String? query}) async {
    final countries = filter?.language;
    final topics = filter?.topic;
    final shortByList = filter?.shortBy;

    final countryCode = (countries != null && countries.isNotEmpty)
        ? countries.first.code
        : 'us';

    final params = <String, dynamic>{QueryParams.country.name: countryCode};

    if (topics != null && topics.isNotEmpty && topics.first.value!.isNotEmpty) {
      params[QueryParams.category.name] = topics.first.value;
    }

    if (shortByList != null && shortByList.isNotEmpty) {
      params[QueryParams.sortBy.name] = shortByList.first.name;
    }

    if (query?.isNotEmpty ?? false) {
      params[QueryParams.q.name] = query;
    }

    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: params,
    );

    if (!(data.succeeded ?? false)) return null;
    return data.data;
  }
}
