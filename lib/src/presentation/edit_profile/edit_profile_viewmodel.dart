import 'package:codegen/model/country_model/country_model.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'edit_profile_viewmodel.g.dart';

class EditProfileViewmodel = _EditProfileViewmodelBase
    with _$EditProfileViewmodel;

abstract class _EditProfileViewmodelBase with Store {
  late final ICountryRepository countryRepository;
  late final IUserRepository userRepository;
  late final IAuthRepository authRepository;

  @observable
  UserModel? user;
  @observable
  Gender? currentGender;

  @observable
  Country? selectedCountry;

  @action
  Future<void> getCurrentUser() async {
    user = await userRepository.getUserInfo();
  }

  @action
  Future<NetworkResponse<bool>> updateUser() async {
    return userRepository.updateProfile(user: user!);
  }
}
