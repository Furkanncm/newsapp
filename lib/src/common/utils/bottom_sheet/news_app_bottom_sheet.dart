import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/base_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/gender_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/presentation/choose_country/choose_country_view.dart';

abstract class NewsAppBottomSheet {
  NewsAppBottomSheet._();

  static Future<Gender?> showGenderBottomSheets(BuildContext context, {Gender? initialGender}) async {
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
      builder: (context) {
        return const FractionallySizedBox(
          heightFactor: 0.8,
          child: BaseBottomSheet(
            title: 'Select your Country',
            child: Expanded(child: ChooseCountryView()),
          ),
        );
      },
    );
  }

  static Future<Filter?> showFilterBottomSheet<Filter>({
    required BuildContext context,
    required List<Country> onlyFilterCountries,
    required List<FilterShortByEnum> shortBy,
    required List<Country> languages,
  }) async {
    return showModalBottomSheet<Filter>(
      context: context,
      builder: (context) {
        return FilterBottomSheet(
          onlyFilterCountries: onlyFilterCountries,
          shortBy: shortBy,
          languages: languages,
          result: router.pop,
        );
      },
    );
  }
}
