import 'package:codegen/model/country_model/country_model.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/news_app_bottom_sheet.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

part 'edit_profile_viewmodel.g.dart';

class EditProfileViewmodel = _EditProfileViewmodelBase
    with _$EditProfileViewmodel;

abstract class _EditProfileViewmodelBase with Store {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController bioController;
  late final TextEditingController websiteController;
  late final TextEditingController genderController;
  late final TextEditingController countryController;
  late final ICountryRepository countryRepository;
  late final IUserRepository userRepository;

  @observable
  UserModel? user;
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

  @action
  Future<void> getCurrentUser() async {
    user = await userRepository.getUserInfo();
  }

  @action
  Future<NetworkResponse<bool>> updateUser() async {
    return userRepository.updateProfile(user: user!);
  }
}
