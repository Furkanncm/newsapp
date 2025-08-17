import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/presentation/topic/topic_view.dart';
import 'package:newsapp/src/presentation/topic/topic_viewmodel.dart';

mixin TopicMixin on State<TopicsView> {
  late final TopicViewmodel viewmodel;
  late final CacheRepository _cacheRepository;
  @override
  void initState() {
    super.initState();
    viewmodel = TopicViewmodel();
    _cacheRepository = CacheRepository.instance;
  }

  void navigateFillProfile() {
    _cacheRepository.setBool(PrefKeys.isTopicSkipped, true);
    router.pushNamed(RoutePaths.fillProfile.name);
  }
}
