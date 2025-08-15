import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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
}
