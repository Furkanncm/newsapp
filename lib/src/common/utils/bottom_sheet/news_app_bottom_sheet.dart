import 'package:codegen/codegen.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/country_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/gender_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';

abstract class NewsAppBottomSheet {
  NewsAppBottomSheet._();

  static Future<Gender?> showGenderBottomSheets(
    BuildContext context, {
    Gender? initialGender,
  }) async {
    return showModalBottomSheet<Gender?>(
      backgroundColor: AppTheme.buttonBackground,
      context: context,
      builder: (context) => GenderBottomSheet(initialGender: initialGender),
    );
  }

  static Future<void> showCountryBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      backgroundColor: AppTheme.buttonBackground,
      isScrollControlled: true,
      context: context,
      builder: (context) => const CountryBottomSheet(),
    );
  }

  static Future<Filter?> showFilterBottomSheet<Filter>({
    required BuildContext context,
    required List<Country> onlyFilterCountries,
    List<FilterShortByEnum>? shortBy,
    List<Country>? languages,
    List<Topic>? topicList,
  }) async {
    return showModalBottomSheet<Filter>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FilterBottomSheet(
          onlyFilterCountries: onlyFilterCountries,
          shortBy: shortBy ?? [],
          languages: languages ?? [],
          topicBy: topicList ?? [],
          result: router.pop,
        );
      },
    );
  }

  
}
