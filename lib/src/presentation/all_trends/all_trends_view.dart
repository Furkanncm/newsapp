import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/other/news_onboard.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

class AllTrendsView extends StatefulWidget {
  const AllTrendsView({super.key});

  @override
  State<AllTrendsView> createState() => _AllTrendsViewState();
}

class _AllTrendsViewState extends State<AllTrendsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(
        title: LocaleKeys.trending.tr(),
        actions: [
          Padding(
            padding: NaPadding.rightPadding,
            child: Assets.uiKitImages.icMoreOutline.toIcon(32),
          ),
        ],
      ),
      body: Padding(
        padding: NaPadding.pagePadding,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return TrendNewsOnboard(onDetail: () {});
          },
        ),
      ),
    );
  }
}
