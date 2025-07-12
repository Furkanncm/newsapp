import 'package:codegen/model/country_model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/rootbundle/root_bundle_repository.dart';
import 'package:newsapp/src/presentation/choose_country/view/choose_country_view.dart';

mixin ChooseCountryMixin on State<ChooseCountryView> {
  final RootBundleManager rootBundleService = RootBundleManager();
  late final CountryRepository _countryRepository;
  ValueNotifier<List<Country>> countryListNotifier = ValueNotifier([]);
  late List<Country> _allCountries;
  Country? selectedCountry;
  late final ValueNotifier<bool> isSelectCountryStateHold;

  late final TextEditingController searchController;
  final ValueNotifier<bool> isAnyWord = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _countryRepository = CountryRepository(rootBundleService: rootBundleService);
    searchController = TextEditingController();
    _getCountriesWithCompute();
    isSelectCountryStateHold = ValueNotifier(false);
  }

  Future<void> _getCountries() async {
    _allCountries = await _countryRepository.getCountries();
    countryListNotifier.value = List.from(_allCountries);
  }

  void _getCountriesWithCompute() => _getCountries();

  void selectCountry(int selectedIndex) {
    final tappedCountry = countryListNotifier.value[selectedIndex];

    if (selectedCountry != null && selectedCountry!.code == tappedCountry.code) {
      selectedCountry = null;
      countryListNotifier.value =
          countryListNotifier.value.map((e) => e.copyWith(isSelected: false)).toList();
      return;
    }

    selectedCountry = tappedCountry;

    final updatedList = countryListNotifier.value.asMap().entries.map((entry) {
      final index = entry.key;
      final country = entry.value;
      return country.copyWith(isSelected: index == selectedIndex);
    }).toList();

    countryListNotifier.value = updatedList;
  }

  void searchCountry(String query) {
    isAnyWord.value = searchController.text.isNotEmpty;
    if (query.isEmpty) {
      countryListNotifier.value = List.from(_allCountries);
    } else {
      countryListNotifier.value = _allCountries.where((country) {
        return (country.name ?? '').toLowerCase().startsWith(
              query.toLowerCase(),
            );
      }).toList();
    }
  }

  void clearController() {
    searchController.clear();
    isAnyWord.value = searchController.text.isNotEmpty;
    countryListNotifier.value = _allCountries;
  }

  void next() {
    if (selectedCountry == null) {
      isSelectCountryStateHold.value = true;
      Future.delayed(const Duration(seconds: 1), () {
        isSelectCountryStateHold.value = false;
      });
    } else {
      _countryRepository.selectCountryAndNext(selectedCountry!);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
