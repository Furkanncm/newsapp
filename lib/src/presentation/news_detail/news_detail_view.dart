import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/enums/bookmark_state.dart';
import 'package:newsapp/src/common/utils/extensions/string_extensions.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/blur_icon.dart';
import 'package:newsapp/src/common/widget/other/circular_progress.dart';
import 'package:newsapp/src/common/widget/other/safe_image_network.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_mixin.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_viewmodel.dart';

@immutable
final class NewsDetailView extends StatefulWidget {
  const NewsDetailView({super.key});

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> with NewsDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (viewmodel.isLoading) {
          return const Material(child: AdaptiveCircular.withoutExpanded());
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _AppBar(
            onBookmarkPressed: () => viewmodel.toggleBookmark(),
            article: article,
            viewmodel: viewmodel,
          ),
          body: _Body(article: article),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async => shareNews(url: article.url ?? ''),
            label: LuciText.bodyMedium(LocaleKeys.share.tr()),
            icon: const Icon(Icons.share),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
      },
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.onBookmarkPressed,
    required this.article,
    required this.viewmodel,
  });

  final VoidCallback? onBookmarkPressed;
  final Article article;
  final NewsDetailViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppTheme.buttonBackground),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          viewmodel.checkBookmark();
          router.pop<BookmarkState>(viewmodel.bookmarkState);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
      actions: [
        horizontalBox8,
        Observer(
          builder: (_) {
            return GestureDetector(
              onTap: () => onBookmarkPressed?.call(),
              child: BlurIcon(
                child: Icon(
                  (viewmodel.isBookmarkedNotifier)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                ),
              ),
            );
          },
        ),
        horizontalBox4,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _News(article: article),
        verticalBox8,
        _NewsSource(article: article),
        _NewsDetails(article: article),
      ],
    );
  }
}

@immutable
final class _News extends StatelessWidget {
  const _News({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _NewsPhoto(article: article),

        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.4),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.25),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

@immutable
final class _NewsPhoto extends StatelessWidget {
  const _NewsPhoto({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      child: SizedBox(
        height: 350,
        width: double.infinity,
        child: SafeImageNetwork(article: article),
      ),
    );
  }
}

@immutable
final class _NewsSource extends StatelessWidget {
  const _NewsSource({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuciText.bodySmall(
            '${LocaleKeys.by.tr()} ${article.source?.name}',
            fontWeight: FontWeight.w600,
            textColor: Colors.grey.shade700,
          ),
          verticalBox4,
          LuciText.bodySmall(
            article.publishedAt?.setPastTime ?? '',
            textColor: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}

@immutable
final class _NewsDetails extends StatelessWidget {
  const _NewsDetails({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: NaPadding.pagePadding.copyWith(top: 20, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalBox4,
          LuciText.titleLarge(
            article.title ?? 'Unknown',
            fontWeight: FontWeight.bold,
          ),
          verticalBox32,
          LuciText.bodyLarge(
            article.content ?? 'There is no content available.',
            textColor: AppTheme.bodyText,
          ),
        ],
      ),
    );
  }
}
