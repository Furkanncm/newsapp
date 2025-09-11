import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/presentation/choose_country/choose_country_view.dart';

abstract class NewsAppBottomSheet {
  static Future<Gender?> showGenderBottomSheets(
    BuildContext context, {
    Gender? initialGender,
  }) async {
    final genderOptions = Gender.getGenders();
    final selectedGender = genderOptions
        .where((e) => e.label == initialGender?.label)
        .firstOrNull;

    return showModalBottomSheet<Gender?>(
      backgroundColor: AppTheme.buttonBackground,
      context: context,
      builder: (context) {
        return Padding(
          padding: NaPadding.pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalBox8,
              Divider(
                thickness: 4,
                indent: context.width * 0.4,
                endIndent: context.width * 0.4,
              ),
              verticalBox16,
              LuciText.labelMedium('Select your Gender'),
              const Divider(),
              verticalBox8,
              ...genderOptions.map(
                (gender) => _ListItem(
                  gender: gender,
                  selectedGender: selectedGender,
                  onSelected: (value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
              verticalBox16,
            ],
          ),
        );
      },
    );
  }

  static Future<void> showCountryBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      backgroundColor: AppTheme.buttonBackground,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: NaPadding.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalBox8,
                Divider(
                  thickness: 4,
                  indent: context.width * 0.4,
                  endIndent: context.width * 0.4,
                ),
                verticalBox16,
                LuciText.labelMedium('Select your Country'),
                const Divider(),
                verticalBox8,
                const Expanded(child: ChooseCountryView()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
    required this.gender,
    required this.selectedGender,
    required this.onSelected,
  });

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
