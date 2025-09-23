import 'package:codegen/codegen.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'home_viewmodel.g.dart';

class HomeViewmodel = _HomeViewmodelBase with _$HomeViewmodel;

abstract class _HomeViewmodelBase with Store {
  late final IUserRepository userRepository;
  late final INewsRepository newsRepository;

  @observable
   UserModel? currentUser;

  @observable
  int lastestIndex = 0;

  @observable
  bool isSeeAll = false;

  @observable
  News? news;

  @observable
  News? categoryNews;

  @observable
  bool isLoading = false;

  @action
  void changeIndex(int index, Topic topic) {
    lastestIndex = index;
    fetchNewsForCategory(topic);
  }

  @action
  Future<void> fetchTrendingNews() async {
    if (news != null) return;
    news = await newsRepository.fetchTrendingNews();
  }

  @action
  Future<void> fetchNewsForCategory(Topic topic) async {
    isLoading = true;
    categoryNews = await newsRepository.fetchNewsWithFilters(topic:topic);
    isLoading = false;
  }

  @action
  void changeIsSeeAll() => isSeeAll = !isSeeAll;

  @action
  Future<void> refreshLastestNews(Article article, bool isBookmarked) async {
    await newsRepository.refreshArticles(article, isBookmarked);
  }

  @action
  Future<void> getUserInfo() async {
    currentUser= await userRepository.getUserInfo();
  
  }
}
