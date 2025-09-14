import 'package:flutter/material.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';
import 'package:newsapp/src/presentation/bookmark/bookmark_view.dart';
import 'package:newsapp/src/presentation/bookmark/bookmark_viewmodel.dart';

mixin BookmarkMixin on State<BookmarkView> {
  late final BookmarkViewModel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = BookmarkViewModel();
    viewmodel.firebaseDataSource = FirebaseDataSource.instance;

    saf();
  }

  Future<void> saf() async => viewmodel.setArticles();
}
