import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/circular_progress.dart';
import 'package:newsapp/src/common/widget/other/list_last_news.dart';
import 'package:newsapp/src/common/widget/other/search_field.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/presentation/bookmark/bookmark_mixin.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> with BookmarkMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: LuciText.titleMedium(
          LocaleKeys.bookmark.tr(),
          fontWeight: FontWeight.bold,
          textColor: AppTheme.primaryColor,
        ),
      ),
      body: Padding(
        padding: NaPadding.pagePadding,
        child: Column(
          children: [
            const SearchField(),
            verticalBox12,
            Observer(
              builder: (_) {
                return viewmodel.isLoading
                    ? const AdaptiveCircular()
                    : ListLastestNews(
                        newsList: viewmodel.articles!,
                        onRefresh: () => viewmodel.refreshArticles(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
