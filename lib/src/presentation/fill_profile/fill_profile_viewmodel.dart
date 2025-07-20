import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'fill_profile_viewmodel.g.dart';

class FillProfileViewmodel = _FillProfileViewmodelBase with _$FillProfileViewmodel;

abstract class _FillProfileViewmodelBase with Store {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  void next() {
    if (formKey.currentState?.validate() ?? false) return;
  }
}
