import 'package:codegen/model/country_model/country_model.dart';
import 'package:newsapp/src/common/utils/enums/filter_language_enum.dart';
import 'package:newsapp/src/common/utils/enums/root_bundle.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/rootbundle/root_bundle_repository.dart';

abstract class ICountryRepository {
  Country? selectedCountry;
  List<Country>? allCountries;
  List<Country> onlyFilterCountries = [];
  Future<List<Country>> getCountries();
  Future<bool> selectCountryAndNext(Country country);
  Future<Country?> getCountryByName(String name);
  void getFiltersCountry();
}

class CountryRepository implements ICountryRepository {
  factory CountryRepository() {
    return _instance ??= CountryRepository._();
  }
  CountryRepository._();
  static CountryRepository? _instance;

  final IRootBundleManager _rootBundleService = RootBundleManager();

  @override
  Country? selectedCountry;

  @override
  List<Country>? allCountries;

  @override
  List<Country> onlyFilterCountries = [];

  @override
  Future<List<Country>> getCountries() async {
    final listCountry = await _rootBundleService.loadCountries(
      RootBundle.countries,
    );
    allCountries = listCountry;
    return listCountry;
  }

  @override
  Future<bool> selectCountryAndNext(Country selectedCountry) async {
    this.selectedCountry = selectedCountry;
    return CacheRepository.instance.cacheGenericModel(
      selectedCountry.code ?? '',
      const Country(),
    );
  }

  @override
  Future<Country?> getCountryByName(String name) async {
    return allCountries?.firstWhere(
      (c) => c.name?.toLowerCase() == name.toLowerCase(),
    );
  }

  @override
  void getFiltersCountry() {
    onlyFilterCountries.clear();

    for (final country in allCountries!) {
      if (FilterLanguageEnum.values.any(
        (e) => e.name.toLowerCase() == country.code?.toLowerCase(),
      )) {
        onlyFilterCountries.add(country);
      }
    }
  }
}
