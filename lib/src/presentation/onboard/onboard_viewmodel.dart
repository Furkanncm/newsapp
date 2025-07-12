import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/enums/pref_keys.dart';

class OnboardViewmodel {
  OnboardViewmodel() {
    CacheRepository.instance.setBool(PrefKeys.isOnboardActive, false);
  }
  void setOnboardVisibleState() => CacheRepository.instance.setBool(PrefKeys.isOnboardActive, true);
}
