import 'package:cached_network_image/cached_network_image.dart';
import 'package:codegen/model/article_model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class SafeImageNetwork extends StatelessWidget {
  const SafeImageNetwork({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return article.urlToImage != null ? CachedNetworkImage(
      imageUrl: article.urlToImage!,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const _ErrorWidget(),
      placeholder: (context, url) => const SizedBox(
        height: double.infinity,
        child: Center(child: CircularProgressIndicator()),
      ),
    ): const _ErrorWidget();
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 16 / 9,
      child: FittedBox(
        child: Icon(Icons.broken_image, color: AppTheme.bodyDark),
      ),
    );
  }
}
