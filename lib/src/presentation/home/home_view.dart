import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/news_info.dart';
import 'package:newsapp/src/common/widget/other/news_onboard.dart';
import 'package:newsapp/src/common/widget/other/row_see_all.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/data/enums/topics.dart';
import 'package:newsapp/src/presentation/home/home_viewmodel.dart';

@immutable
final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = HomeViewmodel();
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
            const _SearchField(),
            verticalBox12,
            _AnimatedNewsOnboard(viewmodel: viewmodel),
            RowSeeAllWidget(
              text: 'Lastest',
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
final class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: LocaleKeys.search.tr(),
        border: const OutlineInputBorder(),
        prefixIcon: Assets.uiKitImages.icQuestionmarkOutline.toIcon(32),
        suffixIcon: GestureDetector(
          onTap: () {
            //FILTRE
          },
          child: Assets.uiKitImages.icFilterOutline.toIcon(32),
        ),
      ),
    );
  }
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
          duration: const Duration(milliseconds: 400),
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
                      text: 'Trending',
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
        itemCount: Topic.values.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final topic = Topic.values[index];
          return _HorizontalTopic(viewmodel: viewmodel, topic: topic);
        },
      ),
    );
  }
}

@immutable
final class _HorizontalTopic extends StatelessWidget {
  const _HorizontalTopic({required this.viewmodel, required this.topic});

  final HomeViewmodel viewmodel;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: () => viewmodel.changeIndex(topic.index),
          child: Padding(
            padding: NaPadding.rightPadding,
            child: IntrinsicWidth(
              child: Column(
                children: [
                  LuciText.bodyLarge(
                    topic.value,
                    fontWeight: viewmodel.lastestIndex == topic.index
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  verticalBox4,
                  if (viewmodel.lastestIndex == topic.index)
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

@immutable
final class ListLastestNews extends StatelessWidget {
  const ListLastestNews({super.key});

  // final List<News> newsList

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: NaPadding.zeroPadding,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return const LastNews();
        },
      ),
    );
  }
}

@immutable
final class LastNews extends StatelessWidget {
  const LastNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.verticalPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Assets.images.onboard2.toFit,
            ),
          ),
          horizontalBox12,
          const Expanded(
            child: NewsInfo(
              region: 'Europe',
              title:
                  "Ukraine's President Zelensky to BBC: Blood money being paid lorem ipsum lorem ipsum",
              source: 'BBC News',
              pastTime: '14m ago',
            ),
          ),
        ],
      ),
    );
  }
}
