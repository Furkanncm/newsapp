import 'dart:io';

import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/dialog/news_app_dialogs.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/utils/validator/validator.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/common/widget/textfield/email_textfield_with_label.dart';
import 'package:newsapp/src/common/widget/textfield/textfield_with_label.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_mixin.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';

@immutable
final class FillProfileView extends StatefulWidget {
  const FillProfileView({super.key});
  @override
  State<FillProfileView> createState() => _FillProfileViewState();
}

class _FillProfileViewState extends State<FillProfileView> with FillProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(title: LocaleKeys.fillProfile.tr()),
      body: _Body(onNextPressed: setProfilePhoto, imageFile: imageFile, viewmodel: viewmodel),
      bottomNavigationBar: _NextButton(viewmodel: viewmodel),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.onNextPressed,
    required this.imageFile,
    required this.viewmodel,
  });

  final VoidCallback onNextPressed;
  final ValueNotifier<XFile?> imageFile;
  final FillProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: ViewConstants.instance.pagePadding,
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  await LuciDialogs.showDialog(
                    context: context,
                    title: 'Are you sure?',
                    content: 'Are you sure you want to change your profile photo?',
                    positiveButtonLabel: 'YES',
                    negativeButtonLabel: 'NO',
                    positiveButtonCallback: () {},
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _ProfilePhoto(imageFile: imageFile),
                    const _CameraIcon(),
                  ],
                ),
              ),
            ),
            verticalBox48,
            _FormField(viewmodel: viewmodel),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({
    required this.imageFile,
  });

  final ValueNotifier<XFile?> imageFile;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<XFile?>(
      valueListenable: imageFile,
      builder: (context, imageFileValue, child) {
        return CircleAvatar(
          radius: 75,
          backgroundColor: AppTheme.buttonText.withValues(alpha: .3),
          child: imageFileValue != null
              ? ClipOval(
                  child: Image.file(
                    File(imageFileValue.path),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                )
              : const Icon(
                  Icons.person,
                  size: 80,
                  color: AppTheme.surfaceColor,
                ),
        );
      },
    );
  }
}

@immutable
final class _CameraIcon extends StatelessWidget {
  const _CameraIcon();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 4,
      right: 8,
      child: ClipOval(
        child: Container(
          height: 40,
          width: 40,
          color: AppTheme.primaryColor,
          child: const Icon(
            Icons.camera_alt_outlined,
            color: AppTheme.surfaceColor,
          ),
        ),
      ),
    );
  }
}

@immutable
final class _FormField extends StatelessWidget {
  const _FormField({
    required this.viewmodel,
  });

  final FillProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewmodel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWithLabel(
            label: LocaleKeys.username.tr(),
            prefixIcon: const Icon(Icons.person_2_outlined),
            controller: viewmodel.nameController,
            validator: (value) => Validator.isEmptyOrNull(value, LocaleKeys.username.tr()),
          ),
          verticalBox16,
          TextFieldWithLabel(
            label: LocaleKeys.fullName.tr(),
            prefixIcon: const Icon(Icons.person_2_outlined),
            controller: viewmodel.fullNameController,
            validator: (value) => Validator.isEmptyOrNull(value, LocaleKeys.fullName.tr()),
          ),
          verticalBox16,
          EmailFieldWithLabel(emailController: viewmodel.emailController),
          verticalBox16,
          LabelWithStar(
            text: LocaleKeys.phoneNumber.tr(),
          ),
          verticalBox4,
          LuciPhoneTextFormField(
            labelText: '',
            controller: viewmodel.phoneController,
          ),
        ],
      ),
    );
  }
}

@immutable
final class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.viewmodel,
  });

  final FillProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return NewsBottomButton(
      text: LocaleKeys.next.tr(),
      onPressed: viewmodel.next,
    );
  }
}
