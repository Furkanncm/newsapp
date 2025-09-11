import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/topic/topic_view.dart';
import 'package:newsapp/src/presentation/topic/topic_viewmodel.dart';

mixin TopicMixin on State<TopicsView> {
  late final TopicViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = TopicViewmodel();
    viewmodel.userRepository = UserRepository();
  }

  void navigateFillProfile() {
    viewmodel.setSkipped();
    router.pushNamed(RoutePaths.fillProfile.name);
  }

}
