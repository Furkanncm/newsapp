import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class TopicsList extends StatefulWidget {
  const TopicsList({super.key, this.isSearchView = true});

  final bool isSearchView;

  @override
  State<TopicsList> createState() => _TopicsListState();
}

class _TopicsListState extends State<TopicsList> {
  @override
  Widget build(BuildContext context) {
    final listLength = widget.isSearchView ? Topic.allTopics.length : 4;
    return Column(
      children: List.generate(listLength, (index) {
        final topic = Topic.allTopics[index];
        if (index == 0) return emptyBox;
        final isSaved = topic.isSaved;
        return ListTile(
          contentPadding: NaPadding.zeroPadding,
          leading: SizedBox(
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: topic.image,
            ),
          ),
          title: LuciText.bodyLarge(topic.value, fontWeight: FontWeight.w500),
          subtitle: LuciText.bodySmall(
            topic.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: SizedBox(
            width: context.width * 0.18,
            height: context.height * 0.045,
            child: LuciOutlinedButton(
              padding: NaPadding.outlinedButtonPadding,
              borderColor: !isSaved
                  ? AppTheme.primaryColor
                  : AppTheme.buttonBackground,
              backgroundColor: isSaved
                  ? AppTheme.primaryColor
                  : AppTheme.buttonBackground,
              onPressed: () {},
              child: LuciText.bodyMedium(
                textColor: !isSaved
                    ? AppTheme.primaryColor
                    : AppTheme.buttonBackground,
                isSaved ? LocaleKeys.saved.tr() : LocaleKeys.save.tr(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}
