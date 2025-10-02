import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/utils/decoration/textfield_decoration/phone_number_formatter.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_view.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_viewmodel.dart';

mixin EditProfileMixin on State<EditProfileView> {
  late final EditProfileViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = EditProfileViewmodel();
    viewmodel.formKey = GlobalKey<FormState>();
    viewmodel.emailController = TextEditingController();
    viewmodel.nameController = TextEditingController();
    viewmodel.fullNameController = TextEditingController();
    viewmodel.phoneController = TextEditingController();
    viewmodel.bioController = TextEditingController();
    viewmodel.websiteController = TextEditingController();
    viewmodel.genderController = TextEditingController();
    viewmodel.countryController = TextEditingController();
    viewmodel.countryRepository = CountryRepository();
    viewmodel.userRepository = UserRepository();
    getUser();
  }

  Future<void> getUser() async {
    await viewmodel.getCurrentUser();
    final rawPhone = viewmodel.user?.phone ?? '';
    final formattedPhone = PhoneNumberFormatter()
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: rawPhone),
        )
        .text;
    final user = viewmodel.user;
    viewmodel.emailController.text = user?.email ?? '';
    viewmodel.nameController.text = user?.username ?? '';
    viewmodel.fullNameController.text = user?.name ?? '';
    viewmodel.phoneController.text = formattedPhone;
    viewmodel.bioController.text = user?.bio ?? '';
    viewmodel.websiteController.text = user?.website ?? '';
    _setGender();
    await _setCountry();
  }

  void _setGender() {
    if (viewmodel.user?.gender != null && viewmodel.user!.gender!.isNotEmpty) {
      final selectedGender = Gender.getGenders().firstWhere(
        (g) => g.label.toLowerCase() == viewmodel.user!.gender!.toLowerCase(),
        orElse: () => Gender.getGenders().last,
      );
      viewmodel.currentGender = selectedGender;
      viewmodel.genderController.text = selectedGender.label;
    }
  }

  Future<void> _setCountry() async {
    if (viewmodel.user?.country != null &&
        viewmodel.user!.country!.isNotEmpty) {
      final selectedCountry = await viewmodel.countryRepository
          .getCountryByName(viewmodel.user!.country!);
      if (selectedCountry != null) {
        viewmodel.selectedCountry = selectedCountry;
        viewmodel.countryController.text = selectedCountry.name ?? '';
      }
    }
  }

  Future<void> editProfile() async {
    if (!(viewmodel.formKey.currentState?.validate() ?? false)) return;
    viewmodel.user = viewmodel.userRepository.currentUser?.copyWith(
      email: viewmodel.emailController.text,
      username: viewmodel.nameController.text,
      name: viewmodel.fullNameController.text,
      phone: viewmodel.phoneController.text,
      bio: viewmodel.bioController.text,
      website: viewmodel.websiteController.text,
      gender: viewmodel.genderController.text,
      country: viewmodel.countryController.text,
    );
    final result = await viewmodel
        .updateUser()
        .withToast(context, successMessage: LocaleKeys.editProfileSuccess.tr())
        .withIndicator(context);
    if (result?.data ?? false) {
      router.go(RoutePaths.profile.path);
    }
  }

  @override
  void dispose() {
    viewmodel.nameController.dispose();
    viewmodel.fullNameController.dispose();
    viewmodel.emailController.dispose();
    viewmodel.phoneController.dispose();
    viewmodel.bioController.dispose();
    viewmodel.websiteController.dispose();
    viewmodel.genderController.dispose();
    viewmodel.countryController.dispose();
    super.dispose();
  }
}
