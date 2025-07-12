import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/enums/otp_options_enum.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/data/model/otp_model.dart';

part 'forgot_passwprd_viewmodel.g.dart';

class ForgotPasswordViewmodel = _ForgotPasswordViewmodelBase with _$ForgotPasswordViewmodel;

abstract class _ForgotPasswordViewmodelBase with Store {
  String emailLabel = LocaleKeys.email.tr();
  String phoneLabel = OTPOptions.sms.value;
  final List<String> options = [
    OTPOptions.email.value,
    OTPOptions.sms.value,
  ];
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  OTPModel? _otpModel;

  @observable
  String selectedOption = OTPOptions.email.value;

  @observable
  bool isSubmitted = false;

  bool get isEmailSelected => selectedOption == options[0];

  @action
  void setSelectedOption(String option) {
    selectedOption = option;
    print('Selected option: $selectedOption');
  }

  @action
  void onSubmit() {
    isSubmitted = true;
    if (emailController.text.isEmpty && phoneController.text.isEmpty) return;
    if (isEmailSelected && emailController.text.isNotEmpty) {
      _otpModel = OTPModel(otpOptions: OTPOptions.email, otpContent: emailController.text);
    } else if (!isEmailSelected && phoneController.text.isNotEmpty) {
      _otpModel = OTPModel(otpOptions: OTPOptions.sms, otpContent: phoneController.text);
    }
    router.pushNamed(RoutePaths.otpVerification.name, extra: _otpModel);
  }
}
