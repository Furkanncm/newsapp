import 'package:codegen/model/country_model/country_model.dart';
import 'package:newsapp/src/common/utils/enums/root_bundle.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/rootbundle/root_bundle_repository.dart';

abstract class ICountryRepository {
  Country? selectedCountry;
  Future<List<Country>> getCountries();
  Future<bool> selectCountryAndNext(Country country);
  Future<Country?> getCountryByName(String name);
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
  Future<List<Country>> getCountries() async {
    return _rootBundleService.loadCountries(RootBundle.countries);
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
    final countries = await getCountries();
    return countries.firstWhere(
      (c) => c.name?.toLowerCase() == name.toLowerCase(),
    );
  }
}
