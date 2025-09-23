import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/base_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_language.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_shortby.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_topic.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/data/model/filter/filter.dart';

@immutable
final class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    required this.onlyFilterCountries,
    required this.shortBy,
    required this.languages,
    required this.result,
    required this.topicBy,
    super.key,
  });

  final List<Country> onlyFilterCountries;
  final List<FilterShortByEnum> shortBy;
  final List<Country> languages;
  final List<Topic> topicBy;
  final void Function(Filter?) result;

  @override
  State<FilterBottomSheet> createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  List<FilterShortByEnum> get newShortBy => widget.shortBy;
  List<Country> get newLanguages => widget.languages;
  List<Topic> get newTopics => widget.topicBy;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: LocaleKeys.filters.tr(),
      onPressed: () {
        widget.result.call(
          Filter(shortBy: newShortBy, language: newLanguages, topic: newTopics),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FilterBottomSheetSection(
            title: LocaleKeys.shortBy.tr(),
            child: FilterShortby(shortBy: newShortBy),
          ),
          const Divider(),
          _FilterBottomSheetSection(
            title: LocaleKeys.languageBy.tr(),
            child: FilterLanguage(
              languages: newLanguages,
              onlyFilterCountries: widget.onlyFilterCountries,
            ),
          ),

          const Divider(),
          horizontalBox8,
          _FilterBottomSheetSection(
            title: LocaleKeys.topicsBy.tr(),
            child: FilterTopic(topics: widget.topicBy),
          ),
        ],
      ),
    );
  }
}

@immutable
final class _FilterBottomSheetSection extends StatelessWidget {
  const _FilterBottomSheetSection({required this.child, required this.title});

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LuciText.bodyMedium(title, fontWeight: FontWeight.bold),
        child,
        horizontalBox8,
      ],
    );
  }
}
