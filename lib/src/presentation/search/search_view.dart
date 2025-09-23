import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/search_page.dart';
import 'package:newsapp/src/common/utils/extensions/bookmarked_extensions.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/circular_progress.dart';
import 'package:newsapp/src/common/widget/other/list_last_news.dart';
import 'package:newsapp/src/common/widget/other/search_field.dart';
import 'package:newsapp/src/common/widget/other/topics_list.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/presentation/search/search_mixin.dart';
import 'package:newsapp/src/presentation/search/search_viewmodel.dart';

@immutable
final class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SearchMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (viewmodel.onlyFilterCountries.isEmpty) {
            return const AdaptiveCircular.withoutExpanded();
          }
          return Padding(
            padding: NaPadding.pagePadding,
            child: Column(
              children: [
                verticalBox64,
                verticalBox16,
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SearchField(
                            controller: controller,
                            onChanged: (value) {
                              viewmodel.onSearchChanged(value);
                            },
                            focusNode: FocusNode(),
                          ),
                        ),
                        horizontalBox4,
                        Container(
                          decoration: BoxDecoration(
                            border: BoxBorder.all(),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            onPressed: () async => onFilteredPressed(),
                            icon: const Icon(
                              Icons.tune_outlined,
                              color: AppTheme.backgroundDark,
                            ),
                          ),
                        ),
                      ],
                    ),

                    verticalBox20,
                    _HorizontalTopicList(viewmodel: viewmodel),
                    verticalBox20,
                  ],
                ),
                Observer(
                  builder: (context) {
                    if (viewmodel.lastestIndex == 0) {
                      return ListLastestNews(
                        newsList: viewmodel.filteredNews,
                        onRefresh: (article, bookmarkedState) async =>
                            viewmodel.newsRepository.refreshArticles(
                              article,
                              bookmarkedState.toBool() ?? false,
                            ),
                      );
                    }
                    if (viewmodel.lastestIndex == 1) {
                      return const Expanded(child: TopicsList());
                    }
                    return emptyBox;
                  },
                ),

                verticalBox16,
              ],
            ),
          );
        },
      ),
    );
  }
}

@immutable
final class _HorizontalTopicList extends StatelessWidget {
  const _HorizontalTopicList({required this.viewmodel});
  final SearchViewmodel viewmodel;
  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(SearchEnum.values.length, (index) {
            final searchItem = SearchEnum.values[index];
            return _HorizontalTopic(
              searchItem: searchItem,
              viewmodel: viewmodel,
            );
          }),
        ),
      ),
    );
  }
}

@immutable
final class _HorizontalTopic extends StatelessWidget {
  const _HorizontalTopic({required this.searchItem, required this.viewmodel});

  final SearchEnum searchItem;
  final SearchViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: () => viewmodel.changeIndex(searchItem.index),
          child: Padding(
            padding: NaPadding.rightPadding,
            child: IntrinsicWidth(
              child: Column(
                children: [
                  LuciText.bodyLarge(searchItem.name),
                  verticalBox4,
                  if (viewmodel.lastestIndex == searchItem.index)
                    Container(
                      height: 3,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(8),
                          right: Radius.circular(8),
                        ),
                      ),
                    )
                  else
                    emptyBox,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
