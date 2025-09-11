import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/country_model/country_model.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/news_app_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
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

  Future<void> next(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final currentUser = await userRepository.getUserInfo();
    final user = currentUser?.copyWith(
      username: usernameController.text,
      name: fullNameController.text,
      bio: bioController.text,
      phone: phoneController.text,
      isSkipped: true,
      gender: currentGender?.label,
      country: selectedCountry?.name,
      website: websiteController.text,
    );
    if (user == null || !context.mounted) return;
    await userRepository
        .updateProfile(user: user)
        .withToast(context, successMessage: LocaleKeys.editProfileSuccess.tr());
    router.goNamed(RoutePaths.home.name);
  }
}
