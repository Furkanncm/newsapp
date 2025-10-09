import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/bottom_sheet/news_app_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/gender/gender.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_view.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

mixin FillProfileMixin on State<FillProfileView> {
  late final FillProfileViewmodel viewmodel;
  late final XFile imageFile;
  late final List<Topic> selectedTopics;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController usernameController;
  late final TextEditingController fullNameController;
  late final TextEditingController bioController;
  late final TextEditingController phoneController;
  late final TextEditingController genderController;
  late final TextEditingController countryController;
  late final TextEditingController websiteController;

  @override
  void initState() {
    super.initState();
    viewmodel = FillProfileViewmodel();
    viewmodel.userRepository = UserRepository();
    viewmodel.countryRepository = CountryRepository();

    _initControllers();
    _fillControllers();

    selectedTopics = GoRouter.of(context).state.extra! as List<Topic>;
  }

  void skipProfile(BuildContext context) {
    viewmodel.userRepository.setSkipped();
    router.goNamed(RoutePaths.home.name);
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

  Future<void> onNextPressed() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final user = _setUser();
    if (user == null) return;
    await viewmodel
        .onNextPressed(user)
        .withToast(
          context,
          showSuccessToast: false,
          onSuccess: () async => router.goNamed(RoutePaths.home.name),
        );
  }

  UserModel? _setUser() {
    final currentUser = viewmodel.userRepository.currentUser;
    return currentUser?.copyWith(
      username: usernameController.text,
      name: fullNameController.text,
      bio: bioController.text,
      phone: phoneController.text,
      isSkipped: true,
      topics: selectedTopics,
      gender: viewmodel.currentGender?.label,
      country: viewmodel.selectedCountry?.name,
      website: websiteController.text,
    );
  }

  void _initControllers() {
    formKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    fullNameController = TextEditingController();
    bioController = TextEditingController();
    phoneController = TextEditingController();
    genderController = TextEditingController();
    countryController = TextEditingController();
    websiteController = TextEditingController();
  }

  void _fillControllers() {
    viewmodel.selectedCountry = viewmodel.countryRepository.selectedCountry;
    viewmodel.currentUser = viewmodel.userRepository.currentUser;
    fullNameController.text = viewmodel.currentUser?.name ?? '';
  }

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    bioController.dispose();
    phoneController.dispose();
    genderController.dispose();
    countryController.dispose();
    websiteController.dispose();
    super.dispose();
  }
}
