// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/data/enums/topics.dart';
import 'package:newsapp/src/presentation/topic/topic_mixin.dart';
import 'package:newsapp/src/presentation/topic/topic_viewmodel.dart';

@immutable
final class TopicsView extends StatefulWidget {
  const TopicsView({super.key});
  @override
  State<TopicsView> createState() => _TopicsViewState();
}

class _TopicsViewState extends State<TopicsView> with TopicMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(title: LocaleKeys.chooseYourTopics.tr()),
      body: _Body(viewmodel: viewmodel),
      bottomNavigationBar: _NextButton(viewmodel: viewmodel),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.viewmodel,
  });

  final TopicViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalBox16,
        Padding(
          padding: ViewConstants.instance.pagePadding,
          child: Wrap(
            spacing: 10,
            runSpacing: 12,
            children: Topic.values.map((topic) {
              return _TopicWidget(
                viewmodel: viewmodel,
                topic: topic,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

@immutable
final class _TopicWidget extends StatelessWidget {
  const _TopicWidget({
    required this.viewmodel,
    required this.topic,
  });

  final TopicViewmodel viewmodel;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: () {
            viewmodel.addTopicToList(topic);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
            decoration: BoxDecoration(
              color:
                  viewmodel.isSelected(topic) ? AppTheme.primaryColor : AppTheme.buttonBackground,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.primaryColor),
            ),
            child: _CategoryWidget(
              viewmodel: viewmodel,
              topic: topic,
            ),
          ),
        );
      },
    );
  }
}

@immutable
final class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({
    required this.viewmodel,
    required this.topic,
  });

  final TopicViewmodel viewmodel;

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          topic.icon,
          color: viewmodel.isSelected(topic) ? AppTheme.buttonBackground : AppTheme.primaryColor,
        ),
        horizontalBox12,
        LuciText.bodyLarge(
          topic.value,
          textColor:
              viewmodel.isSelected(topic) ? AppTheme.buttonBackground : AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

@immutable
final class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.viewmodel,
  });

  final TopicViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return NewsBottomButton(
          text: LocaleKeys.next.tr(),
          onPressed: viewmodel.selectedTopics.isNotEmpty ? () {} : null,
        );
      },
    );
  }
}
