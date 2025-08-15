import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/list_last_news.dart';
import 'package:newsapp/src/common/widget/other/search_field.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
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
      body: const Padding(
        padding: NaPadding.pagePadding,
        child: Column(
          children: [SearchField(), verticalBox12, ListLastestNews()],
        ),
      ),
    );
  }
}
