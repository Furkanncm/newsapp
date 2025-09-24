import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/other/circular_progress.dart';
import 'package:newsapp/src/common/widget/other/profile_photo.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/common/widget/textfield/bio_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/email_textfield_with_label.dart';
import 'package:newsapp/src/common/widget/textfield/full_name_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/label_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/phone_number_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/user_name_textfield.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_mixin.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

@immutable
final class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    with EditProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(
        title: LocaleKeys.editProfile.tr(),
        actions: [
          IconButton(
            onPressed: editProfile,
            icon: const Icon(Icons.check_outlined),
          ),
        ],
      ),
      body: _Body(
        onPressed: () => setProfilePhoto(context),
        imageFile: imageFile,
        viewmodel: viewmodel,
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.onPressed,
    required this.imageFile,
    required this.viewmodel,
  });

  final VoidCallback onPressed;
  final ValueNotifier<XFile?> imageFile;
  final EditProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return viewmodel.user == null
            ? const AdaptiveCircular.withoutExpanded()
            : ListView(
                padding: NaPadding.pagePadding,
                physics: const ClampingScrollPhysics(),
                children: [
                  ProfilePhotoWidget(
                    onPressed: onPressed,
                    imageFile: imageFile,
                  ),
                  verticalBox32,
                  UserNameTextfield(nameController: viewmodel.nameController),
                  verticalBox12,
                  FullNameTextfield(
                    fullNameController: viewmodel.fullNameController,
                  ),
                  verticalBox12,
                  _FormWidget(viewmodel: viewmodel),
                  BioTextField(
                    controller: viewmodel.bioController,
                    bio: viewmodel.bioController.text,
                  ),
                  verticalBox12,
                  _GenderAndCountryPicker(viewmodel: viewmodel),
                  verticalBox12,
                  LabelTextField(
                    label: LocaleKeys.website.tr(),
                    prefixIcon: const Icon(Icons.link_outlined),
                    controller: viewmodel.websiteController,
                    userInfo: viewmodel.websiteController.text,
                  ),
                ],
              );
      },
    );
  }
}

@immutable
final class _GenderAndCountryPicker extends StatelessWidget {
  const _GenderAndCountryPicker({required this.viewmodel});

  final EditProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(
          builder: (_) {
            return Expanded(
              child: LabelTextField(
                onTap: () => viewmodel.setGender(context: context),
                prefixIcon: viewmodel.currentGender?.icon,
                label: LocaleKeys.gender.tr(),
                controller: viewmodel.genderController,
                userInfo: viewmodel.currentGender?.label ?? '',
              ),
            );
          },
        ),
        horizontalBox16,
        Observer(
          builder: (_) {
            return Expanded(
              child: LabelTextField(
                onTap: () async => viewmodel.onCountryTap(context),
                label: LocaleKeys.country.tr(),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      viewmodel.selectedCountry?.flag ?? '',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.flag_circle_outlined);
                      },
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                controller: viewmodel.countryController,
                userInfo: viewmodel.selectedCountry?.name ?? '',
              ),
            );
          },
        ),
      ],
    );
  }
}

@immutable
final class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({
    required this.onPressed,
    required this.imageFile,
    super.key,
  });
  final VoidCallback onPressed;
  final ValueNotifier<XFile?> imageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed.call,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ProfilePhoto(imageFile: imageFile),
            const CameraIcon(),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _FormWidget extends StatelessWidget {
  const _FormWidget({required this.viewmodel});

  final EditProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewmodel.formKey,
      child: Column(
        children: [
          EmailFieldWithLabel(
            emailController: viewmodel.emailController,
            readOnly: true,
          ),
          verticalBox12,
          PhoneNumberTextfield(phoneController: viewmodel.phoneController),
          verticalBox12,
        ],
      ),
    );
  }
}
