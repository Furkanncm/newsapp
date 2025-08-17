import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/snackbar_enum.dart';
import 'package:newsapp/src/common/utils/snackbar/snackbar.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/share/share_manager.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_view.dart';
import 'package:share_plus/share_plus.dart';

mixin NewsDetailMixin on State<NewsDetailView> {
  final CacheRepository _repository = CacheRepository.instance;
  ValueNotifier<bool> isBookmarked = ValueNotifier(false);

  Future<void> shareNews({required String url}) async {
    final status = await ShareManager.instance.shareNewsLink(url);
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

  Future<void> saveNews(Article article) async {
    // Firebase'e bağlanacak
    final existingArticle = await _repository.getGenericModel<Article>(
      article.url ?? '',
      const Article(),
    );

    if (existingArticle != null) {
      final result = await _repository.removeGenericModel(
        existingArticle.url ?? '',
        existingArticle,
      );
      if (result != false) {
        isBookmarked.value = false;
      }

      return;
    }
    final result = await _repository.cacheGenericModel<Article>(
      article.url ?? '',
      article,
    );
    if (result != false) {
      isBookmarked.value = true;
    }
  }
}
