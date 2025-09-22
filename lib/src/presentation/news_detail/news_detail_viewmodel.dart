import 'package:codegen/codegen.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/enums/bookmark_state.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';

part 'news_detail_viewmodel.g.dart';

class NewsDetailViewmodel = _NewsDetailViewmodelBase with _$NewsDetailViewmodel;

abstract class _NewsDetailViewmodelBase with Store {
  late final INewsRepository newsRepository;

  @observable
  ObservableList<Article> savedNews = ObservableList<Article>();

  @observable
  bool isLoading = false;

  @observable
  bool isBookmarkedNotifier = false;

  bool isInitialBookMarkedNotifier = false;

  BookmarkState bookmarkState = BookmarkState.nothingChanged;

  @action
  Future<void> fetchNews([Article? current]) async {
    changeLoading();
    final news = await newsRepository.fetchNews();
    savedNews = ObservableList.of(news);

    if (current != null) {
      isBookmarkedNotifier = isBookmarked(current);
    }
    changeLoading();
  }

  @action
  Future<void> toggleBookmark() async {
    isBookmarkedNotifier = !isBookmarkedNotifier;
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  bool isBookmarked(Article article) {
    return savedNews.any((savedArticle) {
      return article.url == savedArticle.url;
    });
  }

  void checkBookmark() {
    if (isBookmarkedNotifier == isInitialBookMarkedNotifier) {
      bookmarkState = BookmarkState.nothingChanged;
    } else {
      switch (isBookmarkedNotifier) {
        case true:
          bookmarkState = BookmarkState.bookmarked;
        case false:
          bookmarkState = BookmarkState.notBookmarked;
      }
    }
  }

   void handlePop() {
    checkBookmark();
    router.pop<BookmarkState>(bookmarkState);
  }
}
