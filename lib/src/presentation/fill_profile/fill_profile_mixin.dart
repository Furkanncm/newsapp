import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_view.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

mixin FillProfileMixin on State<FillProfileView> {
  late final FillProfileViewmodel viewmodel;
  late final XFile imageFile;

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
  }


  void skipProfile(BuildContext context) {
    viewmodel.userRepository.setSkipped();
    router.goNamed(RoutePaths.home.name);
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
