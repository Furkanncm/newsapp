import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/country_model/country_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/presentation/choose_country/view/choose_country_mixin.dart';

class ChooseCountryView extends StatefulWidget {
  const ChooseCountryView({super.key});
  @override
  State<ChooseCountryView> createState() => _ChooseCountryViewState();
}

class _ChooseCountryViewState extends State<ChooseCountryView> with ChooseCountryMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LuciText.labelMedium(
          LocaleKeys.selectCountry.tr(),
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => router.goNamed(RoutePaths.home.name),
            child: LuciText.bodyLarge(
              LocaleKeys.skip.tr(),
            ),
          ),
        ],
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
                              textColor:
                                  item.isSelected == true ? AppTheme.bodyDark : AppTheme.bodyText,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          emptyBox,
        ],
      ),
      bottomNavigationBar: BottomButton(text: LocaleKeys.next.tr(), onPressed: () {}),
    );
  }
}
