import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/firebase_firestore/firebase_firestore_repository.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

part 'otp_verification_viewmodel.g.dart';

class OTPVerificationViewmodel = _OTPVerificationViewmodelBase
    with _$OTPVerificationViewmodel;

abstract class _OTPVerificationViewmodelBase with Store {
  late final StreamController<ErrorAnimationType> errorController;

  late final TextEditingController pinCodeController;

  late final IAuthRepository authRepository;

  late final IFirebaseFirestoreRepository firestoreRepository;

  late final ICountryRepository countryRepository;

  @observable
  int secondsRemaining = 60;

  @observable
  bool isPinComp = false;

  @observable
  bool isRetry = false;

  Timer? timer;

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
    timer?.cancel();
  }

  @action
  void decrementTimer() {
    secondsRemaining--;
  }

  @action
  Future<NetworkResponse<bool>> verifyPressed() async {
    pinCompleted();
    return authRepository.verifyPhoneNumber(smsCode: pinCodeController.text);
  }

  @action
  void pinCompleted() => isPinComp = true;
}
