import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class NewsDetailView extends StatelessWidget {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final article = GoRouter.of(context).state.extra! as Article;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppTheme.buttonBackground),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Image.network(
                  article.url ?? '',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                      Colors.black.withOpacity(0.25),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: NaPadding.pagePadding.copyWith(top: 20, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LuciText.bodySmall(
                    'By ${article.author}',
                    fontWeight: FontWeight.w600,
                    textColor: Colors.grey.shade700,
                  ),
                  verticalBox4,
                  LuciText.bodySmall(
                    '14m ago',
                    textColor: Colors.grey.shade600,
                  ),
                  verticalBox12,
                  LuciText.titleLarge(
                    article.title,
                    fontWeight: FontWeight.bold,
                  ),
                  verticalBox20,
                  LuciText.bodyLarge(
                    article.content,
                    textColor: AppTheme.bodyText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Paylaş'),
        icon: const Icon(Icons.share),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
