import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/base_bottom_sheet.dart';
import 'package:newsapp/src/presentation/choose_country/choose_country_view.dart';

class CountryBottomSheet extends StatelessWidget {
  const CountryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: BaseBottomSheet(
        title: LocaleKeys.selectCountry.tr(),
        child: const Expanded(child: ChooseCountryView()),
      ),
    );
  }
}
