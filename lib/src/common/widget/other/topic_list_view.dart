import 'package:flutter/material.dart';
import 'package:newsapp/src/common/widget/other/topics_list.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

class TopicListView extends StatefulWidget {
  const TopicListView({super.key});

  @override
  State<TopicListView> createState() => _TopicListViewState();
}

class _TopicListViewState extends State<TopicListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: NaPadding.pagePadding,
        children: const [TopicsList()],
      ),
    );
  }
}
