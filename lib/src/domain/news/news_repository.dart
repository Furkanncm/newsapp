import 'package:codegen/codegen.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';

class NewsRepository {
  factory NewsRepository() {
    return _instance ??= NewsRepository._internal();
  }

  NewsRepository._internal() {
    _firebaseDataSource = FirebaseDataSource.instance;
  }

  static NewsRepository? _instance;

  late final FirebaseDataSource _firebaseDataSource;

  Future<List<Article>> fetchNews() async {
   return  _firebaseDataSource.getNews();
  }

  Future<void> saveNews(Article article, bool isBookmarked) async {
    await fetchNews();
    if (isBookmarked) {
      await _firebaseDataSource.removeNews(article);
    } else {
      await _firebaseDataSource.saveNews(article);
    }
  }

}
