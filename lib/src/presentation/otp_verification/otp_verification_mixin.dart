import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/enums/otp_options_enum.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/firebase_firestore/firebase_firestore_repository.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_view.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

mixin OtTPVerificationMixin on State<OtpVerificationView> {
  late final OTPVerificationViewmodel viewmodel;
  OTPModel? extra;

  @override
  void initState() {
    super.initState();

    viewmodel = OTPVerificationViewmodel();
    viewmodel
      ..countryRepository = CountryRepository()
      ..errorController = StreamController<ErrorAnimationType>()
      ..pinCodeController = TextEditingController()
      ..authRepository = AuthRepository()
      ..firestoreRepository = FirebaseFirestoreRepository()
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
    await viewmodel.verifyPressed().withToast(
      context,
      successMessage: 'Your phone number is verified',
    );
    viewmodel.pinCodeController.clear();
    if (extra == null) return;
    extra!.otpOptions == OTPOptions.verifyWithNumber
        ? router.goNamed(RoutePaths.home.name)
        : await router.pushNamed(RoutePaths.resetPassword.name);
  }

  @override
  void dispose() {
    viewmodel.timer?.cancel();
    super.dispose();
  }
}
