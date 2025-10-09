import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/decorations/na_border_radius.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/other/profile_photo.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/common/widget/textfield/bio_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/full_name_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/label_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/phone_number_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/user_name_textfield.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_mixin.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';

@immutable
final class FillProfileView extends StatefulWidget {
  const FillProfileView({super.key});
  @override
  State<FillProfileView> createState() => _FillProfileViewState();
}

class _FillProfileViewState extends State<FillProfileView>
    with FillProfileMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          router.goNamed(RoutePaths.profile.name);
        }
      },
      child: Scaffold(
        appBar: NewsAppBar(title: LocaleKeys.fillProfile.tr()),
        body: _Body(
          viewmodel: viewmodel,
          onSetGender: setGender,
          onSetCountry: onCountryTap,
          formKey: formKey,
          nameController: usernameController,
          fullNameController: fullNameController,
          phoneController: phoneController,
          bioController: bioController,
          websiteController: websiteController,
          genderController: genderController,
          countryController: countryController,
        ),
        bottomNavigationBar: _NextButton(onPressed: onNextPressed),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.viewmodel,
    required this.onSetGender,
    required this.onSetCountry,
    required this.formKey,
    required this.nameController,
    required this.fullNameController,
    required this.phoneController,
    required this.bioController,
    required this.websiteController,
    required this.genderController,
    required this.countryController,
  });

  final FillProfileViewmodel viewmodel;
  final VoidCallback onSetGender;
  final VoidCallback onSetCountry;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController bioController;
  final TextEditingController websiteController;
  final TextEditingController genderController;
  final TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: NaPadding.pagePadding,
        child: Column(
          children: [
            ProfilePhoto(imagepath: viewmodel.currentUser?.profilePhoto ?? ''),
            verticalBox16,
            _FormField(
              viewmodel: viewmodel,
              onSetGender: onSetGender,
              onSetCountry: onSetCountry,
              formKey: formKey,
              nameController: nameController,
              fullNameController: fullNameController,
              phoneController: phoneController,
              bioController: bioController,
              websiteController: websiteController,
              genderController: genderController,
              countryController: countryController,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _FormField extends StatelessWidget {
  const _FormField({
    required this.viewmodel,
    required this.onSetGender,
    required this.onSetCountry,
    required this.formKey,
    required this.nameController,
    required this.fullNameController,
    required this.phoneController,
    required this.bioController,
    required this.websiteController,
    required this.genderController,
    required this.countryController,
  });

  final FillProfileViewmodel viewmodel;
  final VoidCallback onSetGender;
  final VoidCallback onSetCountry;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController bioController;
  final TextEditingController websiteController;
  final TextEditingController genderController;
  final TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserNameTextfield(nameController: nameController),
          verticalBox12,
          FullNameTextfield(fullNameController: fullNameController),
          verticalBox12,
          PhoneNumberTextfield(phoneController: phoneController),
          verticalBox12,
          BioTextField(controller: bioController, bio: bioController.text),
          verticalBox12,
          Row(
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
                      onTap: () async => onSetCountry(),
                      label: LocaleKeys.country.tr(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: NaBorderRadius.smallRadius(),
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
          ),
          verticalBox12,
          LabelTextField(
            label: LocaleKeys.website.tr(),
            prefixIcon: const Icon(Icons.link_outlined),
            controller: websiteController,
            userInfo: websiteController.text,
          ),
        ],
      ),
    );
  }
}

@immutable
final class _NextButton extends StatelessWidget {
  const _NextButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NewsBottomButton(text: LocaleKeys.next.tr(), onPressed: onPressed);
  }
}
