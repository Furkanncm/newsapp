import 'package:codegen/codegen.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

part 'news_detail_viewmodel.g.dart';

class NewsDetailViewmodel = _NewsDetailViewmodelBase with _$NewsDetailViewmodel;

abstract class _NewsDetailViewmodelBase with Store {
  late final INewsRepository newsRepository ;

  @observable
  ObservableList<Article> savedNews = ObservableList<Article>();

  @observable
  bool? isBookmarkedNotifier;

  @action
  Future<void> fetchNews([Article? current]) async {
    final news = await newsRepository.fetchNews();
    savedNews = ObservableList.of(news);

    if (current != null) {
      isBookmarkedNotifier = isBookmarked(current);
    }
  }

  @action
  Future<void> toggleBookmark() async {
    isBookmarkedNotifier = !(isBookmarkedNotifier ?? false);
  }

  bool isBookmarked(Article article) {
    return savedNews.any((savedArticle) {
      print(article.url == savedArticle.url);
      return article.url == savedArticle.url;
    });
  }
}
