import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/share/share_manager.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_view.dart';
import 'package:share_plus/share_plus.dart';

mixin NewsDetailMixin on State<NewsDetailView> {
  final CacheRepository _repository = CacheRepository.instance;
  ValueNotifier<bool> isBookmarked = ValueNotifier(false);

  Future<void> shareNews(String url) async {
    final status = await ShareManager.instance.shareNewsLink(url);
    switch (status) {
      case ShareResultStatus.success:
        _showSnackBar(
          text: LocaleKeys.successShared.tr(),
          backgroundColor: Colors.green.shade600,
          icon: Icons.check_circle_outline,
        );
      case ShareResultStatus.dismissed:
        _showSnackBar(
          text: LocaleKeys.warningShared.tr(),
          backgroundColor: AppTheme.warningColor,
          icon: Icons.warning_outlined,
        );
      case ShareResultStatus.unavailable:
        _showSnackBar(
          text: LocaleKeys.errorShared.tr(),
          backgroundColor: AppTheme.errorColor,
          icon: Icons.error_outline_outlined,
        );
    }
  }

  void _showSnackBar({
    required String text,
    Color? backgroundColor,
    IconData? icon,
    Color? iconColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppTheme.bodyDark,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(icon, color: iconColor ?? Colors.white),
                ),
              Expanded(
                child: LuciText.bodyMedium(text, textColor: Colors.white),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> saveNews(Article article) async {
    // Firebase'e bağlanacak
    final existingArticle = await _repository.getGenericModel<Article>(
      article.url ?? '',
      Article(),
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
