import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/enums/otp_options_enum.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';

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
  late final GlobalKey<FormState> formKey;

  OTPModel? _otpModel;

  @observable
  String selectedOption = OTPOptions.email.value;

  @observable
  bool isSubmitted = false;

  @observable
  bool isValid = false;

  bool get isEmailSelected => selectedOption == options[0];

  @action
  void setSelectedOption(String option) {
    selectedOption = option;
  }

  @action
  void onSubmit() {
    isSubmitted = true;
    if (isEmailSelected) {
      _otpModel = OTPModel(otpOptions: OTPOptions.email, otpContent: emailController.text);
    } else if (!isEmailSelected) {
      _otpModel = OTPModel(otpOptions: OTPOptions.sms, otpContent: phoneController.text);
    }
    if (!(formKey.currentState?.validate() ?? false)) {
      isValid = true;
      return;
    }
    router.pushNamed(RoutePaths.otpVerification.name, extra: _otpModel);
  }
}
