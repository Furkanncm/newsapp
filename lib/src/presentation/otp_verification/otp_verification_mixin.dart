import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_view.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_viewmodel.dart';

mixin OtTPVerificationMixin on State<OtpVerificationView> {
  late final OTPVerificationViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = OTPVerificationViewmodel();
    viewmodel.pinCodeController = TextEditingController();
    viewmodel.startTimer();
  }

  Future<void> verify() async {
    viewmodel
      ..stopTimer()
      ..isRetry = false
      ..isPinComp = false;

    final result = await router.pushNamed(RoutePaths.resetPassword.name);
    if (result == true) {
      viewmodel.startTimer();
    }
  }

  @override
  void dispose() {
    viewmodel.timer?.cancel();
    super.dispose();
  }
}
