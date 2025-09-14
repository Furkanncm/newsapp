import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/circular_progress.dart';
import 'package:newsapp/src/common/widget/other/news_onboard.dart';
import 'package:newsapp/src/common/widget/other/row_see_all.dart';
import 'package:newsapp/src/common/widget/other/topics_list.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/presentation/explore/explore_mixin.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> with ExploreMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LuciText.titleMedium(
          LocaleKeys.explore.tr(),
          fontWeight: FontWeight.bold,
          textColor: AppTheme.primaryColor,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: NaPadding.pagePadding.copyWith(bottom: 0),
              child: RowSeeAllWidget(
                text: LocaleKeys.topic.tr(),
                onSeeAllPressed: () =>
                    router.goNamed(RoutePaths.exploreTopic.name),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: NaPadding.pagePadding,
              child: TopicsList(isSearchView: false),
            ),
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              minHeight: 50,
              maxHeight: 50,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: NaPadding.pagePadding,
                alignment: Alignment.centerLeft,
                child: RowSeeAllWidget(
                  text: LocaleKeys.popularTopic.tr(),
                  isSeeAllVisible: false,
                ),
              ),
            ),
          ),

          Observer(
            builder: (_) {
              if (viewmodel.isLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: AdaptiveCircular.withoutExpanded(),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: NaPadding.pagePadding.copyWith(top: 0),
                    child: TrendNewsOnboard(
                      onDetail: () => router.pushNamed(
                        RoutePaths.newsDetail.name,
                        extra: viewmodel.news!.articles![index],
                      ),
                      article: viewmodel.news!.articles![index],
                    ),
                  );
                }, childCount: viewmodel.news?.articles?.length ?? 0),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
