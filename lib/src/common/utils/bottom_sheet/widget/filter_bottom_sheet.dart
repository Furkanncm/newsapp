import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/base_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_language.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_shortby.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/data/model/filter/filter.dart';


@immutable
final class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    required this.onlyFilterCountries,
    required this.shortBy,
    required this.languages,
    required this.result,
    super.key,
  });

  final List<Country> onlyFilterCountries;
  final List<FilterShortByEnum> shortBy;
  final List<Country> languages;
  final void Function(Filter?) result;

  @override
  State<FilterBottomSheet> createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  List<FilterShortByEnum> get newShortBy => widget.shortBy;
  List<Country> get newLanguages => widget.languages;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Filter Page',
      onPressed: () {
        widget.result.call(Filter(shortBy: newShortBy, language: newLanguages));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuciText.bodyMedium('Short By', fontWeight: FontWeight.bold),
          FilterShortby(shortBy: newShortBy),
          horizontalBox8,
          const Divider(),
          horizontalBox8,
          LuciText.bodyMedium('Language By', fontWeight: FontWeight.bold),
          FilterLanguage(languages: newLanguages, onlyFilterCountries: widget.onlyFilterCountries),
        ],
      ),
    );
  }
}
