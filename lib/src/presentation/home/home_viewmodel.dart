import 'package:codegen/model/news_model/news_model.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/enums/query_params.dart';
import 'package:newsapp/src/common/utils/enums/remote_ds_path.dart';
import 'package:newsapp/src/data/data_source/remote/news_api_ds.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'home_viewmodel.g.dart';

class HomeViewmodel = _HomeViewmodelBase with _$HomeViewmodel;

abstract class _HomeViewmodelBase with Store {
  final IUserRepository userRepository = UserRepository();

  @observable
  int lastestIndex = 0;

  @observable
  bool isSeeAll = false;

  @observable
  News? news;

  @observable
  News? categoryNews;

  @action
  void changeIndex(int index, Topic topic) {
    lastestIndex = index;
    fetchNewsForCategory(topic);
  }

  @action
  Future<void> fetchTrendingNews() async {
    if (news != null) return;
    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: {QueryParams.country.name: 'us'},
    );
    if (data.succeeded ?? false) {
      news = data.data;
    }
  }

  @action
  Future<void> fetchNewsForCategory(Topic topic) async {
    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: {
        QueryParams.country.name: 'us',
        QueryParams.category.name: topic.value,
      },
    );
    if (data.succeeded ?? false) {
      categoryNews = data.data;
    }
  }

  @action
  void changeIsSeeAll() => isSeeAll = !isSeeAll;
}
