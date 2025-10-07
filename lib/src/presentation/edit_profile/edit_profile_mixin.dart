import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/utils/decoration/textfield_decoration/phone_number_formatter.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/news_app_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/enums/otp_options_enum.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_view.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_viewmodel.dart';

mixin EditProfileMixin on State<EditProfileView> {
  late final EditProfileViewmodel viewmodel;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController bioController;
  late final TextEditingController websiteController;
  late final TextEditingController genderController;
  late final TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    viewmodel = EditProfileViewmodel();

    _repositoryInit();
    _controllerInit();

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
    emailController.text = user?.email ?? '';
    nameController.text = user?.username ?? '';
    fullNameController.text = user?.name ?? '';
    phoneController.text = formattedPhone;
    bioController.text = user?.bio ?? '';
    websiteController.text = user?.website ?? '';
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
      genderController.text = selectedGender.label;
    }
  }

  Future<void> _setCountry() async {
    if (viewmodel.user?.country != null &&
        viewmodel.user!.country!.isNotEmpty) {
      final selectedCountry = await viewmodel.countryRepository
          .getCountryByName(viewmodel.user!.country!);
      if (selectedCountry != null) {
        viewmodel.selectedCountry = selectedCountry;
        countryController.text = selectedCountry.name ?? '';
      }
    }
  }

  Future<void> editProfile() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    viewmodel.user = viewmodel.userRepository.currentUser?.copyWith(
      email: emailController.text,
      username: nameController.text,
      name: fullNameController.text,
      phone: phoneController.text,
      bio: bioController.text,
      website: websiteController.text,
      gender: genderController.text,
      country: countryController.text,
    );
    final result = await viewmodel
        .updateUser()
        .withToast(context, successMessage: LocaleKeys.editProfileSuccess.tr())
        .withIndicator(context);
    if (result?.data ?? false) {
      router.go(RoutePaths.profile.path);
    }
  }

  Future<void> setGender({Gender? gender}) async {
    final selected = await NewsAppBottomSheet.showGenderBottomSheets(
      context,
      initialGender: viewmodel.currentGender,
    );
    if (selected != null) {
      viewmodel.currentGender = selected;
      genderController.text = selected.label;
    }
  }

  Future<void> onCountryTap() async {
    await NewsAppBottomSheet.showCountryBottomSheet(context);
    viewmodel.selectedCountry = viewmodel.countryRepository.selectedCountry;
    if (viewmodel.selectedCountry != null) {
      countryController.text = viewmodel.selectedCountry?.name ?? '';
    }
  }

  Future<void> sentVerificat() async {
    final otpModel = OTPModel(
      otpOptions: OTPOptions.sms,
      otpContent: phoneController.text,
    );
    await viewmodel.authRepository
        .sendVerificationCodePhoneNumber(model: otpModel)
        .withToast(context, successMessage: LocaleKeys.verifyCodeSent.tr());
  }

  void _repositoryInit() {
    viewmodel.countryRepository = CountryRepository();
    viewmodel.userRepository = UserRepository();
    viewmodel.authRepository = AuthRepository();
  }

  void _controllerInit() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    nameController = TextEditingController();
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    bioController = TextEditingController();
    websiteController = TextEditingController();
    genderController = TextEditingController();
    countryController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    websiteController.dispose();
    genderController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
