import 'package:codegen/model/topic/topic.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_chip.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
@immutable
final class FilterTopic extends StatefulWidget {
  const FilterTopic({required this.topics, super.key});
  final List<Topic> topics;

  @override
  State<FilterTopic> createState() => FilterTopicState();
}

class FilterTopicState extends State<FilterTopic> {
  List<Topic> get newTopics => widget.topics;

  bool isTopicByItemSelected(Topic topic) {
    return newTopics.contains(topic);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...Topic.allTopics.map((topic) {
          return FilterChipItem(
            avatar: Icon(
              topic.icon,
              color: isTopicByItemSelected(topic)
                  ? AppTheme.buttonBackground
                  : AppTheme.backgroundDark,
            ),
            label: topic.value?.capitalizeFirst ?? '',
            isSelected: isTopicByItemSelected(topic),
            onSelected: (value) {
              final result = isTopicByItemSelected(topic);
              if (result) {
                newTopics.clear();
              } else {
                if (newTopics.length == 1) {
                  newTopics.clear();
                }
                newTopics.add(topic);
              }
              setState(() {});
              return null;
            },
          );
        }),
      ],
    );
  }
}
