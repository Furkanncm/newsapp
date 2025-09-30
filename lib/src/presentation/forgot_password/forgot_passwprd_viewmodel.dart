import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/dialog/news_app_dialogs.dart';
import 'package:newsapp/src/common/utils/enums/otp_options_enum.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';

part 'forgot_passwprd_viewmodel.g.dart';

class ForgotPasswordViewmodel = _ForgotPasswordViewmodelBase
    with _$ForgotPasswordViewmodel;

abstract class _ForgotPasswordViewmodelBase with Store {
  String emailLabel = LocaleKeys.email.tr();
  String phoneLabel = OTPOptions.sms.value;
  final List<String> options = [OTPOptions.email.value, OTPOptions.sms.value];
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final GlobalKey<FormState> formKey;
  late final IAuthRepository authRepository;

  OTPModel? _otpModel;

  @observable
  String selectedOption = OTPOptions.email.value;

  @observable
  bool isSubmitted = false;

  bool get isEmailSelected => selectedOption == options[0];

  @action
  void setSelectedOption(String option) {
    selectedOption = option;
  }

  @action
  Future<void> onSubmit(BuildContext context) async {
    isSubmitted = true;

    if (!(formKey.currentState?.validate() ?? false)) return;
    if (isEmailSelected) {
      _otpModel = OTPModel(
        otpOptions: OTPOptions.email,
        otpContent: emailController.text,
      );
      if (_otpModel == null) return;
      await authRepository.resetPasswordWithEmail(email: _otpModel!.otpContent);
      if (!context.mounted) return;
      await NewsAppDialogs.infoDialog(
        context: context,
        title: '${LocaleKeys.check.tr()}${_otpModel?.otpOptions.value}',
        content:
            '${_otpModel?.otpOptions.value} ${LocaleKeys.sentTo.tr()} ${_otpModel?.otpContent}',
      );
      router.goNamed(RoutePaths.login.name);
    } else {
      _otpModel = OTPModel(
        otpOptions: OTPOptions.sms,
        otpContent: phoneController.text,
      );
      if (_otpModel == null) return;
      await authRepository.sendVerificationCodePhoneNumber(model: _otpModel!);
    }
  }
}
//furkankazic@gmail.com