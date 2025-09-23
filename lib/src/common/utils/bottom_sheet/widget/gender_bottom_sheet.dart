import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/base_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_list_item.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';

@immutable
final class GenderBottomSheet extends StatelessWidget {
  const GenderBottomSheet({super.key, this.initialGender});

  final Gender? initialGender;

  @override
  Widget build(BuildContext context) {
    final genderOptions = Gender.getGenders();
    final selectedGender = genderOptions
        .where((e) => e.label == initialGender?.label)
        .firstOrNull;
    return BaseBottomSheet(
      title: LocaleKeys.selectGender.tr(),
      onPressed: () {},
      child: Column(
        children: [
          ...genderOptions.map(
            (gender) => ListItem(
              gender: gender,
              selectedGender: selectedGender,
              onSelected: router.pop,
            ),
          ),
        ],
      ),
    );
  }
}
