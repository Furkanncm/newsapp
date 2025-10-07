import 'package:codegen/model/country_model/country_model.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'fill_profile_viewmodel.g.dart';

class FillProfileViewmodel = _FillProfileViewmodelBase
    with _$FillProfileViewmodel;

abstract class _FillProfileViewmodelBase with Store {
  late final ICountryRepository countryRepository;
  late final IUserRepository userRepository;

  UserModel? currentUser;

  @observable
  Gender? currentGender;

  @observable
  Country? selectedCountry;

  Future<NetworkResponse<bool>> onNextPressed(UserModel user) async {
    final result = await userRepository.updateProfile(user: user);
    if (result.data == true) {
      userRepository.setCurrentUser(user);
    }
    return result;
  }
}
