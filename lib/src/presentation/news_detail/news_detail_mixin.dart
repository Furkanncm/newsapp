import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/enums/snackbar_enum.dart';
import 'package:newsapp/src/common/utils/snackbar/snackbar.dart';
import 'package:newsapp/src/domain/news/news_repository.dart';
import 'package:newsapp/src/domain/share/share_manager.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_view.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

mixin NewsDetailMixin on State<NewsDetailView> {
  late final NewsDetailViewmodel viewmodel;
  late Article article;
  @override
  void initState() {
    super.initState();
    article = GoRouter.of(context).state.extra! as Article;
    viewmodel = NewsDetailViewmodel();
    viewmodel.newsRepository = NewsRepository();
    fetchNews();
  }

  Future<void> fetchNews() async {
    await viewmodel.fetchNews();
    viewmodel.isBookmarkedNotifier = viewmodel.isBookmarked(article);
    viewmodel.isInitialBookMarkedNotifier = viewmodel.isBookmarkedNotifier;
  }

  Future<void> shareNews({required String url}) async {
    final status = await ShareManager.instance.shareNewsLink(url);
    if (!mounted) return;
    switch (status) {
      case ShareResultStatus.success:
        NewsAppSnackBar.show(
          context: context,
          text: LocaleKeys.successShared.tr(),
          type: SnackBarType.success,
        );
      case ShareResultStatus.dismissed:
        NewsAppSnackBar.show(
          context: context,
          text: LocaleKeys.warningShared.tr(),
          type: SnackBarType.warning,
        );
      case ShareResultStatus.unavailable:
        NewsAppSnackBar.show(
          context: context,
          text: LocaleKeys.errorShared.tr(),
          type: SnackBarType.error,
        );
    }
  }
}
