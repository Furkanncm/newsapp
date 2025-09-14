import 'package:codegen/codegen.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

part 'news_detail_viewmodel.g.dart';

class NewsDetailViewmodel = _NewsDetailViewmodelBase with _$NewsDetailViewmodel;

abstract class _NewsDetailViewmodelBase with Store {
  final NewsRepository newsRepository = NewsRepository();

  @observable
  ObservableList<Article> savedNews = ObservableList<Article>();

  @observable
  bool isBookmarkedNotifier = false;

  @action
  Future<void> fetchNews([Article? current]) async {
    final news = await newsRepository.fetchNews();
    savedNews = ObservableList.of(news);

    if (current != null) {
      isBookmarkedNotifier = isBookmarked(current);
    }
  }

  @action
  Future<void> toggleBookmark(Article article) async {
    final bookmarked = isBookmarked(article);

    if (bookmarked) {
      await newsRepository.saveNews(article, true); 
    } else {
      await newsRepository.saveNews(article, false);
    }

    await fetchNews(article);
  }

  bool isBookmarked(Article article) {
    return savedNews.any((savedArticle) => article.url == savedArticle.url);
  }
}
