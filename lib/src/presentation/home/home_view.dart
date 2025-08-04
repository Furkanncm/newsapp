import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/list_last_news.dart';
import 'package:newsapp/src/common/widget/other/news_onboard.dart';
import 'package:newsapp/src/common/widget/other/row_see_all.dart';
import 'package:newsapp/src/common/widget/other/search_field.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/presentation/home/home_viewmodel.dart';

@immutable
final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewmodel viewmodel;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    viewmodel = HomeViewmodel();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.pagePadding,
      child: Scaffold(
        appBar: const _AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalBox20,
            SearchField(
              controller: controller,
              readOnly: true,
              onTap: () => router.pushNamed(RoutePaths.searchPage.name),
            ),
            verticalBox12,
            _AnimatedNewsOnboard(viewmodel: viewmodel),
            RowSeeAllWidget(
              text: LocaleKeys.latest.tr(),
              onSeeAllPressed: () => viewmodel.changeIsSeeAll(),
            ),
            verticalBox16,
            _HorizontalTopicList(viewmodel: viewmodel),
            const ListLastestNews(),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leadingWidth: context.width / 3.5,
      leading: Assets.images.icAppLogo.toImage,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

@immutable
final class _AnimatedNewsOnboard extends StatelessWidget {
  const _AnimatedNewsOnboard({required this.viewmodel});

  final HomeViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: !viewmodel.isSeeAll
              ? Column(
                  key: const ValueKey(true),
                  children: [
                    RowSeeAllWidget(
                      text: LocaleKeys.trending.tr(),
                      onSeeAllPressed: () {
                        router.pushNamed(RoutePaths.allTrends.name);
                      },
                    ),
                    verticalBox16,
                    TrendNewsOnboard(onDetail: () {}),
                  ],
                )
              : emptyBox,
        );
      },
    );
  }
}

@immutable
final class _HorizontalTopicList extends StatelessWidget {
  const _HorizontalTopicList({required this.viewmodel});

  final HomeViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: NaPadding.zeroPadding,
        itemCount: Topic.allTopics.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final topic = Topic.allTopics[index];
          return _HorizontalTopic(
            viewmodel: viewmodel,
            topic: topic,
            index: index,
          );
        },
      ),
    );
  }
}

@immutable
final class _HorizontalTopic extends StatelessWidget {
  const _HorizontalTopic({
    required this.viewmodel,
    required this.topic,
    required this.index,
  });

  final HomeViewmodel viewmodel;
  final Topic topic;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: () => viewmodel.changeIndex(index),
          child: Padding(
            padding: NaPadding.rightPadding,
            child: IntrinsicWidth(
              child: Column(
                children: [
                  LuciText.bodyLarge(
                    topic.value,
                    fontWeight: viewmodel.lastestIndex == index
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  verticalBox4,
                  if (viewmodel.lastestIndex == index)
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
