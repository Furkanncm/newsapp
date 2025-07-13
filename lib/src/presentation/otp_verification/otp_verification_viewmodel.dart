import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

part 'otp_verification_viewmodel.g.dart';

class OTPVerificationViewmodel = _OTPVerificationViewmodelBase with _$OTPVerificationViewmodel;

abstract class _OTPVerificationViewmodelBase with Store {
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  late final TextEditingController pinCodeController;

  @observable
  int secondsRemaining = 60;
  @observable
  bool isRetry = false;
  Timer? timer;

  @observable
  bool isPinComp = false;

  @action
  void changeRetryState(bool value) => isRetry = value;

  @action
  void startTimer() {
    changeRetryState(false);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
        pinCodeController.clear();
        changeRetryState(true);
      } else {
        decrementTimer();
      }
    });
  }

  @action
  void sendOtp() {
    secondsRemaining = 60;
    changeRetryState(false);
    startTimer();
  }

  @action
  void stopTimer() {
    pinCodeController.clear();
    timer?.cancel();
  }

  @action
  void decrementTimer() {
    secondsRemaining--;
  }

  @action
  void pinCompleted() => isPinComp = true;
}
