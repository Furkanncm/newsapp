import 'package:flutter/material.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_view.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

mixin FillProfileMixin on State<FillProfileView> {
  late final FillProfileViewmodel viewmodel;
  final ValueNotifier<XFile?> imageFile = ValueNotifier(null);
  late final IUserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    viewmodel = FillProfileViewmodel();
    _userRepository = UserRepository();
    viewmodel.formKey = GlobalKey<FormState>();
    viewmodel.emailController = TextEditingController();
    viewmodel.nameController = TextEditingController();
    viewmodel.fullNameController = TextEditingController();
    viewmodel.phoneController = TextEditingController();
  }

  Future<void> setProfilePhoto(BuildContext context) async {
    final result = await _userRepository.setProfilePhoto(context);
    imageFile.value = result;
  }

  @override
  void dispose() {
    viewmodel.emailController.dispose();
    viewmodel.nameController.dispose();
    viewmodel.fullNameController.dispose();
    viewmodel.phoneController.dispose();
    super.dispose();
  }
}
