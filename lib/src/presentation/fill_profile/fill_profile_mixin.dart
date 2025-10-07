import 'package:codegen/generated/locale_keys.g.dart';
import 'package:codegen/model/topic/topic.dart';
import 'package:codegen/model/user/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_view.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

mixin FillProfileMixin on State<FillProfileView> {
  late final FillProfileViewmodel viewmodel;
  late final XFile imageFile;
  late final List<Topic> selectedTopics;

  @override
  void initState() {
    super.initState();
    viewmodel = FillProfileViewmodel();
    viewmodel.userRepository = UserRepository();
    viewmodel.formKey = GlobalKey<FormState>();
    viewmodel.usernameController = TextEditingController();
    viewmodel.fullNameController = TextEditingController();
    viewmodel.bioController = TextEditingController();
    viewmodel.phoneController = TextEditingController();
    viewmodel.genderController = TextEditingController();
    viewmodel.countryController = TextEditingController();
    viewmodel.websiteController = TextEditingController();
    viewmodel.countryRepository = CountryRepository();
    viewmodel.selectedCountry = viewmodel.countryRepository.selectedCountry;
    viewmodel.currentUser = viewmodel.userRepository.currentUser;
    viewmodel.fullNameController.text = viewmodel.currentUser?.name ?? '';
    selectedTopics = GoRouter.of(context).state.extra! as List<Topic>;
  }

  void skipProfile(BuildContext context) {
    viewmodel.userRepository.setSkipped();
    router.goNamed(RoutePaths.home.name);
  }

  Future<void> onNextPressed() async {
    if (!(viewmodel.formKey.currentState?.validate() ?? false)) return;
    final user = _setUser();
    if (user == null) return;
    await viewmodel
        .onNextPressed(user)
        .withToast(
          context,
          successMessage: LocaleKeys.editProfileSuccess.tr(),
          onSuccess: () async => router.goNamed(RoutePaths.home.name),
        );
  }

  UserModel? _setUser() {
    final currentUser = viewmodel.userRepository.currentUser;
    return currentUser?.copyWith(
      username: viewmodel.usernameController.text,
      name: viewmodel.fullNameController.text,
      bio: viewmodel.bioController.text,
      phone: viewmodel.phoneController.text,
      isSkipped: true,
      topics: selectedTopics,
      gender: viewmodel.currentGender?.label,
      country: viewmodel.selectedCountry?.name,
      website: viewmodel.websiteController.text,
    );
  }

  @override
  void dispose() {
    viewmodel.usernameController.dispose();
    viewmodel.fullNameController.dispose();
    viewmodel.bioController.dispose();
    viewmodel.phoneController.dispose();
    viewmodel.genderController.dispose();
    viewmodel.countryController.dispose();
    viewmodel.websiteController.dispose();
    super.dispose();
  }
}
