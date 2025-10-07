import 'package:codegen/model/country_model/country_model.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/news_app_bottom_sheet.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'fill_profile_viewmodel.g.dart';

class FillProfileViewmodel = _FillProfileViewmodelBase
    with _$FillProfileViewmodel;

abstract class _FillProfileViewmodelBase with Store {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController usernameController;
  late final TextEditingController fullNameController;
  late final TextEditingController bioController;
  late final TextEditingController phoneController;
  late final TextEditingController genderController;
  late final TextEditingController countryController;
  late final TextEditingController websiteController;
  late final ICountryRepository countryRepository;
  late final IUserRepository userRepository;

  UserModel? currentUser;

  @observable
  Gender? currentGender;

  @observable
  Country? selectedCountry;

  @action
  Future<void> setGender({
    required BuildContext context,
    Gender? gender,
  }) async {
    final selected = await NewsAppBottomSheet.showGenderBottomSheets(
      context,
      initialGender: currentGender,
    );
    if (selected != null) {
      currentGender = selected;
      genderController.text = selected.label;
    }
  }

  @action
  Future<void> onCountryTap(BuildContext context) async {
    await NewsAppBottomSheet.showCountryBottomSheet(context);
    selectedCountry = countryRepository.selectedCountry;
    if (selectedCountry != null) {
      countryController.text = selectedCountry?.name ?? '';
    }
  }

  Future<NetworkResponse<bool>> onNextPressed(UserModel user) async {
   final result = await userRepository.updateProfile(user: user);
    if (result.data == true) {
      userRepository.setCurrentUser(user);
    }
    return result;
  }
}
