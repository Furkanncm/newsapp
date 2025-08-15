import 'package:codegen/model/country_model/country_model.dart';
import 'package:newsapp/src/common/utils/enums/root_bundle.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/rootbundle/root_bundle_repository.dart';

abstract class ICountryRepository {
  Future<List<Country>> getCountries();
  Future<bool> selectCountryAndNext(Country country);
}

class CountryRepository implements ICountryRepository {
  CountryRepository({required this.rootBundleService});
  final IRootBundleManager rootBundleService;

  @override
  Future<List<Country>> getCountries() async {
    return rootBundleService.loadCountries(RootBundle.countries);
  }

  @override
  Future<bool> selectCountryAndNext(Country selectedCountry) async {
    return CacheRepository.instance.cacheGenericModel(selectedCountry.code ?? '', const Country());
  }
}
