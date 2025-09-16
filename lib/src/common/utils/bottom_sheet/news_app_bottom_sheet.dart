// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/filter_language_enum.dart';
import 'package:newsapp/src/common/utils/enums/filter_shortby_enum.dart';
import 'package:newsapp/src/common/utils/extensions/filter_shortby_extension.dart';
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
        return _BaseBottomSheet(
          title: 'Select your Gender',
          child: Column(
            children: [
              ...genderOptions.map(
                (gender) => _ListItem(
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
      },
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
          child: _BaseBottomSheet(
            title: 'Select your Country',
            child: Expanded(child: ChooseCountryView()),
          ),
        );
      },
    );
  }

  static void showFilterBottomSheet(
    BuildContext context,
    List<Country> onlyFilterCountries,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Asknga(onlyFilterCountries: onlyFilterCountries);
      },
    );
  }
}

class Asknga extends StatelessWidget {
  const Asknga({required this.onlyFilterCountries, super.key});

  final List<Country> onlyFilterCountries;

  @override
  Widget build(BuildContext context) {
    return _BaseBottomSheet(
      title: 'Filter Page',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuciText.bodyMedium('Short By', fontWeight: FontWeight.bold),
          Wrap(
            children: [
              ...FilterShortByEnum.values.map((item) {
                return _FilterItem(
                  avatar: Icon(item.getIcon),
                  label: item.name,
                  onSelected: (value) {
                    return null;
                  },
                );
              }),
            ],
          ),
          horizontalBox8,
          const Divider(),
          horizontalBox8,
          LuciText.bodyMedium('Language By', fontWeight: FontWeight.bold),
          Wrap(
            children: [
              ...onlyFilterCountries.map((language) {
                return _FilterItem(
                  avatar: SizedBox(
                    width: 48,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        language.flag ?? '',
                        width: 40,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  label: language.name?.capitalizeFirst ?? '',
                  onSelected: (value) {
                    return null;
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  const _FilterItem({
    required this.avatar,
    required this.label,
    required this.onSelected,
  });

  final Widget avatar;
  final String label;
  final String? Function(bool value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(right: 8),
      child: FilterChip(
        avatar: avatar,
        disabledColor: Colors.red,
        backgroundColor: Colors.white,
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: const BorderSide(color: AppTheme.backgroundDark),
        ),
        selectedColor: Colors.white,
        label: LuciText.bodySmall(label.capitalizeFirst),
        onSelected: onSelected.call,
      ),
    );
  }
}

class _BaseBottomSheet extends StatelessWidget {
  const _BaseBottomSheet({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
          LuciText.labelMedium(title, fontWeight: FontWeight.bold),
          const Divider(),
          verticalBox8,
          child,
          verticalBox16,
        ],
      ),
    );
  }
}

class Filter {
  Filter({required this.shortBy, required this.language});

  final FilterShortByEnum shortBy;
  final FilterLanguageEnum language;
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
