import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/base_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_list_item.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';


@immutable
final class GenderBottomSheet extends StatelessWidget {
  const GenderBottomSheet({super.key, this.initialGender});

  final Gender? initialGender;

  @override
  Widget build(BuildContext context) {
    final genderOptions = Gender.getGenders();
    final selectedGender = genderOptions.where((e) => e.label == initialGender?.label).firstOrNull;
    return BaseBottomSheet(
      title: 'Select your Gender',
      onPressed: () {},
      child: Column(
        children: [
          ...genderOptions.map(
            (gender) => ListItem(
              gender: gender,
              selectedGender: selectedGender,
              onSelected: (value) {
                Navigator.of(context).pop(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
