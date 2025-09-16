import 'package:codegen/model/article_model/article_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

part 'bookmark_viewmodel.g.dart';

class BookmarkViewModel = _Base with _$BookmarkViewModel;

abstract class _Base with Store {
  late final INewsRepository newsRepository;

  @observable
  List<Article>? articles;

  @observable
  bool isLoading = false;

  @action
  Future<void> setArticles() async {
    changeLoading();
    articles = await newsRepository.fetchNews();
    changeLoading();
  }

  @action
  Future<void> refreshArticles(Article article, bool isBookmarked) async {
    await newsRepository.refreshArticles(article, isBookmarked);

    await setArticles();
  }

  @action
  void changeLoading() => isLoading = !isLoading;
}
