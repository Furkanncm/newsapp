// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/utils/validator/validator.dart';
import 'package:newsapp/src/common/widget/appbar/news_app_bar.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/common/widget/textfield/email_textfield_with_label.dart';
import 'package:newsapp/src/common/widget/textfield/textfield_with_label.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_viewmodel.dart';

class FillProfileView extends StatefulWidget {
  const FillProfileView({super.key});
  @override
  State<FillProfileView> createState() => _FillProfileViewState();
}

class _FillProfileViewState extends State<FillProfileView> {
  late final FillProfileViewmodel viewmodel;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NewsAppBar(title: 'Fill your Profiledsadsa'),
      body: SingleChildScrollView(
        child: Padding(
          padding: ViewConstants.instance.pagePadding,
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Fotoğraf seçme işlemi
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundColor: AppTheme.buttonText.withValues(alpha: .3),
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: AppTheme.surfaceColor,
                        ),
                      ),
                      const Positioned(
                        bottom: 8,
                        right: 8,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppTheme.primaryColor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: AppTheme.surfaceColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalBox48,
              Form(
                key: viewmodel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWithLabel(
                      label: 'Username',
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      controller: viewmodel.nameController,
                      validator: (value) => Validator.isEmptyOrNull(value, 'Username'),
                    ),
                    verticalBox16,
                    TextFieldWithLabel(
                      label: 'Full Name',
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      controller: viewmodel.fullNameController,
                      validator: (value) => Validator.isEmptyOrNull(value, 'Full Name'),
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NewsBottomButton(
        text: LocaleKeys.next.tr(),
        onPressed: viewmodel.next,
      ),
    );
  }
}
