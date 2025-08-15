import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/contact.dart';
import 'package:newsapp/src/common/utils/enums/help.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/domain/url_launcher/url_launcer.dart';

part '../contact/contact_mixin.dart';

@immutable
final class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: Help.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(
        title: LocaleKeys.helpAndSupport.tr(),
        bottom: TabBar(
          controller: _controller,
          unselectedLabelColor: AppTheme.bodyDark,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          tabs: Help.values.map((help) {
            return Tab(text: help.title);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: Help.values.map((help) {
          return help.page;
        }).toList(),
      ),
    );
  }
}
