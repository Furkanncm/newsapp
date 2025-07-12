import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/country_model/country_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/enums/pref_keys.dart';
import 'package:newsapp/src/presentation/choose_country/view/choose_country_mixin.dart';

class ChooseCountryView extends StatefulWidget {
  const ChooseCountryView({super.key});
  @override
  State<ChooseCountryView> createState() => _ChooseCountryViewState();
}

class _ChooseCountryViewState extends State<ChooseCountryView> with ChooseCountryMixin {
  @override
  Widget build(BuildContext context) {
    CacheRepository.instance.setBool(PrefKeys.isOnboardActive, true);
    return Scaffold(
      appBar: AppBar(
        title: LuciText.titleSmall(LocaleKeys.selectCountry.tr()),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: NaPadding.pagePadding,
            child: Column(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: isAnyWord,
                  builder: (context, value, child) {
                    return TextField(
                      controller: searchController,
                      onChanged: searchCountry,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.search.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(value ? Icons.clear_outlined : Icons.search_outlined),
                          onPressed: value ? clearController : null,
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ValueListenableBuilder<List<Country>>(
                    valueListenable: countryListNotifier,
                    builder: (context, value, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: countryListNotifier.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = countryListNotifier.value[index];
                          if (countryListNotifier.value.isEmpty) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return ListTile(
                            selectedTileColor: AppTheme.primaryColor,
                            selected: item.isSelected ?? false,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minTileHeight: 60,
                            onTap: () => selectCountry(index),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                item.flag ?? '',
                                width: 40,
                                height: 30,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 30,
                                    color: Colors.grey.shade300,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.flag_outlined,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                            title: LuciText.bodyLarge(
                              item.name,
                              textColor: item.isSelected == true
                                  ? AppTheme.textColorDark
                                  : AppTheme.textColorLight,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: next,
                  child: Center(child: LuciText.titleSmall(LocaleKeys.next.tr())),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: isSelectCountryStateHold,
              builder: (context, value, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  height: value ? context.height * 0.06 : 0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orangeAccent, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: value
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.warning_amber_outlined, color: Colors.white),
                                LuciText.labelSmall(
                                  LocaleKeys.selectCountry.tr(),
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
          emptyBox,
        ],
      ),
    );
  }
}
