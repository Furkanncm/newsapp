import 'package:codegen/model/article_model/article_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';

part 'bookmark_viewmodel.g.dart';

class BookmarkViewModel = _Base with _$BookmarkViewModel;

abstract class _Base with Store {
  late final FirebaseDataSource firebaseDataSource;

  @observable
  List<Article>? articles;

  @observable
  bool isLoading = false;

  @action
  Future<void> setArticles() async {
    changeLoading();
    articles = await firebaseDataSource.getNews();
    changeLoading();
  }

  @action
  Future<void> refreshArticles() async {
    await setArticles();
  }

  @action
  void changeLoading() => isLoading = !isLoading;
}
