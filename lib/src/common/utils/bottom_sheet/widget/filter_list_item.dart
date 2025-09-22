import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';

@immutable
final class ListItem extends StatelessWidget {
  const ListItem({required this.gender, required this.selectedGender, required this.onSelected, super.key});

  final Gender gender;
  final Gender? selectedGender;
  final ValueChanged<Gender?> onSelected;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<Gender>.adaptive(
      contentPadding: NaPadding.zeroPadding,
      value: gender,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [LuciText.bodyMedium(gender.label), gender.icon],
      ),
      groupValue: selectedGender,
      onChanged: (value) {
        if (value != null) {
          onSelected(value);
        }
      },
    );
  }
}
