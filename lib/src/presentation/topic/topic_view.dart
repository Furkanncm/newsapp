import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
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
      appBar: NewsAppBar(
        title: LocaleKeys.chooseYourTopics.tr(),
        actions: [
          TextButton(
            onPressed: navigateFillProfile,
            child: LuciText.bodyMedium(
              LocaleKeys.skip.tr(),
              textColor: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
      body: _Body(viewmodel: viewmodel),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({required this.viewmodel});

  final TopicViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalBox16,
        Expanded(
          child: GridView.builder(
            padding: NaPadding.pagePadding,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: Topic.allTopics.length - 1,
            itemBuilder: (context, index) {
              final topic = Topic.allTopics[index + 1];
              return topic.value == Topic.allTopics.first.value
                  ? emptyBox
                  : _TopicWidget(viewmodel: viewmodel, topic: topic);
            },
          ),
        ),
        const Spacer(),
        _NextButton(viewmodel: viewmodel),
      ],
    );
  }
}

@immutable
final class _TopicWidget extends StatelessWidget {
  const _TopicWidget({required this.viewmodel, required this.topic});

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
          child: ChoiceChip(
            selectedColor: AppTheme.primaryColor,
            selectedShadowColor: AppTheme.primaryColor,
            checkmarkColor: AppTheme.buttonBackground,
            label: _CategoryWidget(viewmodel: viewmodel, topic: topic),
            selected: viewmodel.isSelected(topic),
            onSelected: (selected) {
              viewmodel.addTopicToList(topic);
            },
          ),
        );
      },
    );
  }
}

@immutable
final class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({required this.viewmodel, required this.topic});

  final TopicViewmodel viewmodel;

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            topic.icon,
            color: viewmodel.isSelected(topic)
                ? AppTheme.buttonBackground
                : AppTheme.primaryColor,
          ),
          horizontalBox12,
          Flexible(
            child: LuciText.bodyLarge(
              topic.value,
              textColor: viewmodel.isSelected(topic)
                  ? AppTheme.buttonBackground
                  : AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
final class _NextButton extends StatelessWidget {
  const _NextButton({required this.viewmodel});

  final TopicViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return NewsBottomButton(
          text: LocaleKeys.next.tr(),
          onPressed: viewmodel.selectedTopics.isNotEmpty
              ? viewmodel.onNextPressed
              : null,
        );
      },
    );
  }
}
