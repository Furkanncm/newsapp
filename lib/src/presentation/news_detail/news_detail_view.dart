import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucielle/utils/extensions/string_extension/string_extension.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/blur_icon.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_mixin.dart';

@immutable
final class NewsDetailView extends StatefulWidget {
  const NewsDetailView({super.key});

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> with NewsDetailMixin {
  @override
  Widget build(BuildContext context) {
    final article = GoRouter.of(context).state.extra! as Article;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _AppBar(
        onBookmarkPressed: () => saveNews(article),
        bookmarkedNotifier: isBookmarked,
      ),
      body: _Body(article: article),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await shareNews(url:article.url ?? '');
        },
        label: LuciText.bodyMedium(LocaleKeys.share.tr()),
        icon: const Icon(Icons.share),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.onBookmarkPressed,
    required this.bookmarkedNotifier,
  });

  final VoidCallback? onBookmarkPressed;
  final ValueNotifier<bool> bookmarkedNotifier;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppTheme.buttonBackground),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        horizontalBox8,
        ValueListenableBuilder(
          valueListenable: bookmarkedNotifier,
          builder: (context, value, child) {
            return GestureDetector(
              onTap: () => onBookmarkPressed?.call(),
              child: BlurIcon(
                child: Icon(value ? Icons.bookmark : Icons.bookmark_border),
              ),
            );
          },
        ),
        horizontalBox4,
        GestureDetector(
          onTap: () {
            // Handle more options tap
          },
          child: const BlurIcon(child: Icon(Icons.more_vert_outlined)),
        ),
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
      child: Hero(
        tag: article.source?.id?.toIntOrNull() ?? 0,
        child: Image.network(
          article.urlToImage ?? '',
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded || frame != null) {
              return AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: child,
              );
            } else {
              return Container(
                height: 350,
                width: double.infinity,
                color: AppTheme.bodyDark,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 350,
              width: double.infinity,
              color: AppTheme.bodyDark,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 350,
              width: double.infinity,
              color: AppTheme.bodyDark,
              child: Center(
                child: Icon(
                  Icons.broken_image,
                  size: 48,
                  color: AppTheme.buttonText.withValues(alpha: 0.5),
                ),
              ),
            );
          },
        ),
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
            '${LocaleKeys.by.tr()} ${article.author}',
            fontWeight: FontWeight.w600,
            textColor: Colors.grey.shade700,
          ),
          verticalBox4,
          LuciText.bodySmall('14m ago', textColor: Colors.grey.shade600),
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
    return Expanded(
      child: SingleChildScrollView(
        padding: NaPadding.pagePadding.copyWith(top: 20, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalBox4,
            LuciText.titleLarge(article.title, fontWeight: FontWeight.bold),
            verticalBox32,
            LuciText.bodyLarge(article.content, textColor: AppTheme.bodyText),
          ],
        ),
      ),
    );
  }
}
