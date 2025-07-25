import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucielle/widget/bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_view.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';

mixin FillProfileMixin on State<FillProfileView> {
  late final FillProfileViewmodel viewmodel;
  final ValueNotifier<XFile?> imageFile = ValueNotifier(null);
  int _count = 0;

  @override
  void initState() {
    super.initState();
    viewmodel = FillProfileViewmodel();
    viewmodel.formKey = GlobalKey<FormState>();
    viewmodel.emailController = TextEditingController();
    viewmodel.nameController = TextEditingController();
    viewmodel.fullNameController = TextEditingController();
    viewmodel.phoneController = TextEditingController();
  }

  Future<void> setProfilePhoto() async {
    final result = await ImagePickerBottomSheet().showImagePickerBottomSheet(
      showDragHandle: true,
      context: context,
      bottomSheetBackgroundColor: AppTheme.buttonBackground,
      textColor: AppTheme.bodyText,
      buttonBackgroundColor: AppTheme.bodyDark,
    );
    if (result == null) {
      _count++;
      return;
    }
    if (_count == 2) {
      
    }
    imageFile.value = result;
  }

  Future<void> routeAppSettings() async {
    await AppSettings.openAppSettings();
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
