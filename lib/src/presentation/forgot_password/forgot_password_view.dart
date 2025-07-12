import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/common/widget/textfield/email_texfield.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_passwprd_viewmodel.dart';

@immutable
final class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final ForgotPasswordViewmodel viewmodel;
  @override
  void initState() {
    super.initState();
    viewmodel = ForgotPasswordViewmodel();
    viewmodel.emailController = TextEditingController();
    viewmodel.phoneController = TextEditingController();
  }

  @override
  void dispose() {
    viewmodel.emailController.dispose();
    viewmodel.phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
      padding: ViewConstants.instance.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LuciText.titleLarge(
            LocaleKeys.forgotPasswordTitle.tr(),
            fontWeight: FontWeight.bold,
          ),
          verticalBox16,
          LuciText.bodyLarge(
            LocaleKeys.forgotPasswordSubtitle.tr(),
            textColor: AppTheme.backgroundDark.withValues(alpha: 0.8),
          ),
          verticalBox32,
          Observer(
            builder: (context) {
              return viewmodel.isSubmitted
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text:
                                viewmodel.isEmailSelected ? LocaleKeys.email.tr() : 'Mobile number',
                            children: const [
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: AppTheme.errorColor),
                              ),
                            ],
                          ),
                        ),
                        verticalBox4,
                        if (viewmodel.isEmailSelected)
                          EmailTextField(emailController: emailController)
                        else
                          LuciPhoneTextFormField(
                            labelText: '',
                            controller: phoneController,
                          ),
                      ],
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
final class _EmailAndPhoneNumber extends StatelessWidget {
  const _EmailAndPhoneNumber({
    required this.viewmodel,
  });

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
    this.onChanged,
  });

  final String option;
  final String selectedOption;
  final String title;
  final String description;
  final ForgotPasswordViewmodel viewmodel;
  final void Function(String?)? onChanged;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged!(option),
      child: Card(
        color: Colors.grey[250],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
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
                const _MailIcon(),
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
  const _MailIcon();

  @override
  Widget build(BuildContext context) {
    return const Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      color: AppTheme.primaryColor,
      child: Padding(
        padding: NaPadding.elevatedButtonPadding,
        child: Icon(
          Icons.mail_outline_outlined,
          size: 30,
          color: AppTheme.backgroundLight,
        ),
      ),
    );
  }
}

@immutable
final class _TitleAndDescription extends StatelessWidget {
  const _TitleAndDescription({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalBox4,
        LuciText.bodySmall(
          title,
          textColor: AppTheme.surfaceDarkColor.withValues(alpha: 0.7),
        ),
        verticalBox8,
        LuciText.bodyMedium(
          description,
        ),
      ],
    );
  }
}

@immutable
final class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.viewmodel,
  });

  final ForgotPasswordViewmodel viewmodel;
  @override
  Widget build(BuildContext context) {
    return BottomButton(
      text: LocaleKeys.submit.tr(),
      onPressed: viewmodel.onSubmit,
    );
  }
}
