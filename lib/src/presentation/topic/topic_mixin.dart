import 'package:flutter/material.dart';
import 'package:newsapp/src/presentation/topic/topic_view.dart';
import 'package:newsapp/src/presentation/topic/topic_viewmodel.dart';

mixin TopicMixin  on State<TopicsView>{
    late final TopicViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = TopicViewmodel();
  }

}