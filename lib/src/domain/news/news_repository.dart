import 'package:codegen/codegen.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:newsapp/src/common/utils/enums/query_params.dart';
import 'package:newsapp/src/common/utils/enums/remote_ds_path.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';
import 'package:newsapp/src/data/data_source/remote/news_api_ds.dart';

abstract class INewsRepository {
  Future<List<Article>> fetchNews();
  Future<void> saveNews(Article article, bool isBookmarked);
  Future<void> refreshArticles(Article article, bool isBookmarked);
  Future<News?> fetchTrendingNews();
  Future<News?> fetchNewsForCategory(Topic topic);
}

class NewsRepository implements INewsRepository {
  factory NewsRepository() {
    return _instance ??= NewsRepository._internal();
  }

  NewsRepository._internal() {
    _firebaseDataSource = FirebaseDataSource.instance;
  }

  static NewsRepository? _instance;

  late final FirebaseDataSource _firebaseDataSource;



  @override
  Future<List<Article>> fetchNews() async {
    return _firebaseDataSource.getNews();
  }

  @override
  Future<void> saveNews(Article article, bool isBookmarked) async {
    await fetchNews();
    if (isBookmarked) {
      await _firebaseDataSource.removeNews(article);
    } else {
      await _firebaseDataSource.saveNews(article);
    }
  }

  @override
  Future<void> refreshArticles(Article article, bool isBookmarked) async {
    await saveNews(article, !isBookmarked);
  }

  @override
  Future<News?> fetchTrendingNews() async {
    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: {QueryParams.country.name: 'us'},
    );
    if (data.succeeded ?? false) {
      return data.data;
    }

    return null;
  }

  @override
  Future<News?> fetchNewsForCategory(Topic topic) async {
    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: {
        QueryParams.country.name: 'us',
        QueryParams.category.name: topic.value,
      },
    );
    if (data.succeeded ?? false) {
      return data.data;
    }
    return null;
  }
}
