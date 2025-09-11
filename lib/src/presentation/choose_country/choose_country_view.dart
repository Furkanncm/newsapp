import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/presentation/choose_country/choose_country_mixin.dart';

@immutable
final class ChooseCountryView extends StatefulWidget {
  const ChooseCountryView({super.key});
  @override
  State<ChooseCountryView> createState() => _ChooseCountryViewState();
}

class _ChooseCountryViewState extends State<ChooseCountryView>
    with ChooseCountryMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: isAnyWord,
            builder: (context, value, child) {
              return TextField(
                controller: searchController,
                onChanged: searchCountry,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: LocaleKeys.search.tr(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      value ? Icons.clear_outlined : Icons.search_outlined,
                      color: AppTheme.buttonText,
                    ),
                    onPressed: value ? clearController : null,
                  ),
                ),
              );
            },
          ),
          verticalBox12,
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: countryListNotifier,
              builder: (context, value, child) {
                if (countryListNotifier.value.isEmpty && isAnyWord.value) {
                  return Center(
                    child: LuciText.bodyLarge(
                      LocaleKeys.doesNotFoundAnyCountry.tr(),
                    ),
                  );
                }
                if (countryListNotifier.value.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: countryListNotifier.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _CountrListTile(
                      country: countryListNotifier.value[index],
                      onCountrySelected: () => selectCountry(index),
                    );
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isSelectCountryStateHold,
            builder: (context, value, child) {
              return SizedBox(
                height: context.height * .06,
                child: LuciElevatedButton(
                  backgroundColor: value
                      ? AppTheme.primaryColor
                      : AppTheme.placeholder.withValues(alpha: 0.5),
                  onPressed: isSelectCountryStateHold.value ? next : null,
                  child: Center(
                    child: LuciText.bodyMedium(LocaleKeys.next.tr()),
                  ),
                ),
              );
            },
          ),
          verticalBox16,
        ],
      ),
    );
  }
}

@immutable
final class _CountrListTile extends StatelessWidget {
  const _CountrListTile({
    required this.country,
    required this.onCountrySelected,
  });

  final Country country;
  final void Function() onCountrySelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 48,
      selected: country.isSelected ?? false,
      selectedTileColor: AppTheme.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: SizedBox(
        width: 48,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            country.flag ?? '',
            width: 40,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: LuciText.bodyLarge(
        country.name ?? '',
        textColor: country.isSelected == true
            ? AppTheme.buttonBackground
            : AppTheme.bodyText,
      ),
      onTap: onCountrySelected,
    );
  }
}
