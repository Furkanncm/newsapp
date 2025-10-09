import 'dart:async';

import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/enums/otp_options_enum.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_view.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

mixin OtTPVerificationMixin on State<OtpVerificationView> {
  late final OTPVerificationViewmodel viewmodel;
  late final StreamController<ErrorAnimationType> errorController;
  late final TextEditingController pinCodeController;
  OTPModel? extra;

  @override
  void initState() {
    super.initState();
    viewmodel = OTPVerificationViewmodel();
    errorController = StreamController<ErrorAnimationType>();
    pinCodeController = TextEditingController();
    viewmodel
      ..countryRepository = CountryRepository()
      ..authRepository = AuthRepository()
      ..userRepository = UserRepository()
      ..startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    extra ??= GoRouterState.of(context).extra as OTPModel?;
  }

  Future<void> onVerifyPressed() async {
    viewmodel
      ..stopTimer()
      ..isRetry = false
      ..isPinComp = false;
    await viewmodel
        .verifyPressed(smsCode: pinCodeController.text)
        .withToast(
          context,
          successMessage: LocaleKeys.phoneNumber.tr(),
          onSuccess: () async {
            pinCodeController.clear();
            extra!.otpOptions == OTPOptions.verifyWithNumber
                ? router.goNamed(RoutePaths.home.name)
                : await router.pushNamed(RoutePaths.resetPassword.name);
          },
        );
  }

  @override
  void dispose() {
    viewmodel.timer?.cancel();
    super.dispose();
  }
}
