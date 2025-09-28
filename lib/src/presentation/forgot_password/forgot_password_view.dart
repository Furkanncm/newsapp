import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/common/widget/textfield/email_textfield_with_label.dart';
import 'package:newsapp/src/common/widget/textfield/phone_number_textfield.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_password_mixin.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_passwprd_viewmodel.dart';

@immutable
final class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView>
    with ForgotPasswordMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: router.pop,
        ),
      ),
      body: _Body(
        viewmodel: viewmodel,
        emailController: viewmodel.emailController,
        phoneController: viewmodel.phoneController,
      ),
      bottomNavigationBar: _SubmitButton(viewmodel: viewmodel),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.viewmodel,
    required this.emailController,
    required this.phoneController,
  });

  final ForgotPasswordViewmodel viewmodel;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuciText.headlineSmall(
            LocaleKeys.forgotPasswordTitle.tr(),
            fontWeight: FontWeight.bold,
          ),
          verticalBox16,
          LuciText.bodyLarge(
            LocaleKeys.forgotPasswordSubtitle.tr(),
            textColor: AppTheme.bodyText,
          ),
          verticalBox32,
          Observer(
            builder: (context) {
              return viewmodel.isSubmitted
                  ? _TextFields(
                      viewmodel: viewmodel,
                      emailController: emailController,
                      phoneController: phoneController,
                    )
                  : _EmailAndPhoneNumber(viewmodel: viewmodel);
            },
          ),
        ],
      ),
    );
  }
}

@immutable
final class _TextFields extends StatelessWidget {
  const _TextFields({
    required this.viewmodel,
    required this.emailController,
    required this.phoneController,
  });

  final ForgotPasswordViewmodel viewmodel;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewmodel.formKey,
      child: Visibility(
        visible: viewmodel.isEmailSelected,
        replacement: PhoneNumberTextfield(phoneController: phoneController),
        child: EmailFieldWithLabel(emailController: emailController),
      ),
    );
  }
}

@immutable
final class _EmailAndPhoneNumber extends StatelessWidget {
  const _EmailAndPhoneNumber({required this.viewmodel});

  final ForgotPasswordViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) {
            return _OptionCard(
              option: viewmodel.options[0],
              selectedOption: viewmodel.selectedOption,
              title: LocaleKeys.viaEmail.tr(),
              description: LocaleKeys.exampleGmail.tr(),
              icon: Icons.mail_outline_outlined,
              viewmodel: viewmodel,
              onChanged: (value) => viewmodel.setSelectedOption(value!),
              isSelected: viewmodel.isEmailSelected,
            );
          },
        ),
        verticalBox12,
        Observer(
          builder: (_) {
            return _OptionCard(
              option: viewmodel.options[1],
              selectedOption: viewmodel.selectedOption,
              title: LocaleKeys.viaSMS.tr(),
              description: LocaleKeys.examplePhoneNumber.tr(),
              icon: Icons.phone,
              viewmodel: viewmodel,
              onChanged: (value) => viewmodel.setSelectedOption(value!),
              isSelected: !viewmodel.isEmailSelected,
            );
          },
        ),
      ],
    );
  }
}

@immutable
final class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.option,
    required this.selectedOption,
    required this.title,
    required this.description,
    required this.viewmodel,
    required this.isSelected,
    required this.icon,
    this.onChanged,
  });

  final String option;
  final String selectedOption;
  final String title;
  final String description;
  final ForgotPasswordViewmodel viewmodel;
  final void Function(String?)? onChanged;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged!(option),
      child: Card(
        color: AppTheme.buttonBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: isSelected ? AppTheme.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: context.height * 0.07,
            width: double.infinity,
            child: Row(
              children: [
                _MailIcon(icon: icon),
                horizontalBox16,
                _TitleAndDescription(title: title, description: description),
                const Spacer(),
                Radio<String>(
                  value: option,
                  groupValue: selectedOption,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
final class _MailIcon extends StatelessWidget {
  const _MailIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      color: AppTheme.primaryColor,
      child: Padding(
        padding: NaPadding.elevatedButtonPadding,
        child: Icon(icon, size: 30, color: AppTheme.disabledInput),
      ),
    );
  }
}

@immutable
final class _TitleAndDescription extends StatelessWidget {
  const _TitleAndDescription({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalBox4,
        LuciText.bodySmall(title, textColor: AppTheme.placeholder),
        verticalBox8,
        LuciText.bodyMedium(description),
      ],
    );
  }
}

@immutable
final class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.viewmodel});

  final ForgotPasswordViewmodel viewmodel;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return NewsBottomButton(
          text: LocaleKeys.submit.tr(),
          onPressed: () => viewmodel.onSubmit(context),
        );
      },
    );
  }
}
