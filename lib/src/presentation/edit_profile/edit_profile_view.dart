import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/decorations/na_border_radius.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          router.goNamed(RoutePaths.profile.name);
        }
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => router.goNamed(RoutePaths.profile.name),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: LuciText.labelMedium(
            LocaleKeys.editProfile.tr(),
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: editProfile,
              icon: const Icon(Icons.check_outlined),
            ),
          ],
        ),
        body: _Body(
          viewmodel: viewmodel,
          formKey: formKey,
          nameController: nameController,
          fullNameController: fullNameController,
          emailController: emailController,
          phoneController: phoneController,
          bioController: bioController,
          websiteController: websiteController,
          genderController: genderController,
          countryController: countryController,
          onSetGender: setGender,
          onSetCountry: onCountryTap,
          onVerifyEmail: sentVerificationEmail,
        ),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.viewmodel,
    required this.formKey,
    required this.nameController,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.bioController,
    required this.websiteController,
    required this.genderController,
    required this.countryController,
    required this.onSetGender,
    required this.onSetCountry,
    required this.onVerifyEmail,
  });

  final EditProfileViewmodel viewmodel;

  final VoidCallback onSetGender;
  final VoidCallback onSetCountry;
  final VoidCallback onVerifyEmail;

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController bioController;
  final TextEditingController websiteController;
  final TextEditingController genderController;
  final TextEditingController countryController;

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
                  const PhotoWithCameraIcon(),
                  verticalBox32,
                  UserNameTextfield(nameController: nameController),
                  verticalBox12,
                  FullNameTextfield(fullNameController: fullNameController),
                  verticalBox12,
                  _FormWidget(
                    formKey: formKey,
                    emailController: emailController,
                    phoneController: phoneController,
                    onVerifyEmail: onVerifyEmail,
                  ),
                  BioTextField(
                    controller: bioController,
                    bio: bioController.text,
                  ),
                  verticalBox12,
                  _GenderAndCountryPicker(
                    viewmodel: viewmodel,
                    genderController: genderController,
                    countryController: countryController,
                    onSetGender: onSetGender,
                    onSetCountry: onSetCountry,
                  ),
                  verticalBox12,
                  LabelTextField(
                    label: LocaleKeys.website.tr(),
                    prefixIcon: const Icon(Icons.link_outlined),
                    controller: websiteController,
                    userInfo: websiteController.text,
                  ),
                ],
              );
      },
    );
  }
}

@immutable
final class _GenderAndCountryPicker extends StatelessWidget {
  const _GenderAndCountryPicker({
    required this.viewmodel,
    required this.genderController,
    required this.countryController,
    required this.onSetGender,
    required this.onSetCountry,
  });

  final EditProfileViewmodel viewmodel;
  final TextEditingController genderController;
  final TextEditingController countryController;
  final VoidCallback onSetGender;
  final VoidCallback onSetCountry;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(
          builder: (_) {
            return Expanded(
              child: LabelTextField(
                onTap: onSetGender,
                prefixIcon: viewmodel.currentGender?.icon,
                label: LocaleKeys.gender.tr(),
                controller: genderController,
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
                onTap: onSetCountry,
                label: LocaleKeys.country.tr(),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius:NaBorderRadius.smallRadius(),
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
                controller: countryController,
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
final class _FormWidget extends StatelessWidget {
  const _FormWidget({
    required this.onVerifyEmail,
    required this.formKey,
    required this.emailController,
    required this.phoneController,
  });

  final VoidCallback onVerifyEmail;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          EmailFieldWithLabel(
            emailController: emailController,
            readOnly: true,
            isForVerify: true,
            onPressed: onVerifyEmail,
          ),
          verticalBox12,
          PhoneNumberTextfield(
            phoneController: phoneController,
            isForVerifyPhoneNumber: true,
          ),
          verticalBox12,
        ],
      ),
    );
  }
}
