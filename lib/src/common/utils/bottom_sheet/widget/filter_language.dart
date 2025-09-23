import 'package:codegen/model/country_model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/widget/filter_chip.dart';

@immutable
final class FilterLanguage extends StatefulWidget {
  const FilterLanguage({
    required this.languages,
    required this.onlyFilterCountries,
    super.key,
  });

  final List<Country> languages;
  final List<Country> onlyFilterCountries;

  @override
  State<FilterLanguage> createState() => _FilterLanguageState();
}

class _FilterLanguageState extends State<FilterLanguage> {
  bool isLangugeItemSelected(Country item) {
    return widget.languages.contains(item);
  }

  List<Country> get newLanguages => widget.languages;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...widget.onlyFilterCountries.map((language) {
          return FilterChipItem(
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
            isSelected: isLangugeItemSelected(language),
            onSelected: (value) {
              final result = isLangugeItemSelected(language);
              if (result) {
                newLanguages.clear();
              } else {
                if (newLanguages.length == 1) {
                  newLanguages.clear();
                }
                newLanguages.add(language);
              }
              setState(() {});
              return null;
            },
          );
        }),
      ],
    );
  }
}
