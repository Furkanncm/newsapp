import 'package:codegen/model/news_model/news_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/enums/query_params.dart';
import 'package:newsapp/src/common/utils/enums/remote_ds_path.dart';
import 'package:newsapp/src/data/data_source/remote/news_api_ds.dart';

part 'explore_viewmodel.g.dart';

class ExploreViewmodel = _Base with _$ExploreViewmodel;

abstract class _Base with Store {
  @observable
  News? news;


 @observable
  bool isLoading = false;

  @action
  Future<void> fetchTrendingNews() async {
    changeLoading();
    if (news != null) return;
    final data = await NewsApiDs().fetch<News>(
      path: RemoteDsPath.topheadlines,
      queryParameters: {QueryParams.country.name: 'us'},
    );
    if (data.succeeded ?? false) {
      news = data.data;
    }
    changeLoading();
  }

    @action
  void changeLoading() => isLoading = !isLoading;
}
