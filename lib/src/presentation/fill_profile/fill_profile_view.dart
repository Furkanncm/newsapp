import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/other/profile_photo.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/common/widget/textfield/email_textfield_with_label.dart';
import 'package:newsapp/src/common/widget/textfield/full_name_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/phone_number_textfield.dart';
import 'package:newsapp/src/common/widget/textfield/user_name_textfield.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_mixin.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';
import 'package:share_plus/share_plus.dart';

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
    return Scaffold(
      appBar: NewsAppBar(title: LocaleKeys.fillProfile.tr()),
      body: _Body(
        imageFile: imageFile,
        viewmodel: viewmodel,
        onPressed: () => setProfilePhoto(context),
      ),
      bottomNavigationBar: _NextButton(viewmodel: viewmodel),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.imageFile,
    required this.viewmodel,
    required this.onPressed,
  });

  final ValueNotifier<XFile?> imageFile;
  final FillProfileViewmodel viewmodel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: NaPadding.pagePadding,
        child: Column(
          children: [
            PhotoChange(onPressed: onPressed, imageFile: imageFile),
            verticalBox48,
            _FormField(viewmodel: viewmodel),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _FormField extends StatelessWidget {
  const _FormField({required this.viewmodel});

  final FillProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewmodel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserNameTextfield(nameController: viewmodel.nameController),
          verticalBox16,
          FullNameTextfield(fullNameController: viewmodel.fullNameController),
          verticalBox16,
          EmailFieldWithLabel(emailController: viewmodel.emailController),
          verticalBox16,
          PhoneNumberTextfield(phoneController: viewmodel.phoneController),
        ],
      ),
    );
  }
}

@immutable
final class _NextButton extends StatelessWidget {
  const _NextButton({required this.viewmodel});

  final FillProfileViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return NewsBottomButton(
      text: LocaleKeys.next.tr(),
      onPressed: viewmodel.next,
    );
  }
}
