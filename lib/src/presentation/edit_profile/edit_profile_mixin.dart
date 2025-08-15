import 'package:flutter/material.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_view.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

mixin EditProfileMixin on State<EditProfileView> {
  late final EditProfileViewmodel viewmodel;
  final ValueNotifier<XFile?> imageFile = ValueNotifier(null);
  late final IUserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    viewmodel = EditProfileViewmodel();
    _userRepository = UserRepository();
    viewmodel.formKey = GlobalKey<FormState>();
    viewmodel.emailController = TextEditingController();
    viewmodel.nameController = TextEditingController();
    viewmodel.fullNameController = TextEditingController();
    viewmodel.phoneController = TextEditingController();
    viewmodel.bioController = TextEditingController();
    viewmodel.websiteController = TextEditingController();
  }

  Future<void> setProfilePhoto(BuildContext context) async {
    final result = await _userRepository.setProfilePhoto(context);
    imageFile.value = result;
  }

  void editProfile() {
    if (!(viewmodel.formKey.currentState?.validate() ?? false)) return;
    //inputtan user al.
    // firebase user update.
  }
}
