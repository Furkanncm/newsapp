// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OTPVerificationViewmodel on _OTPVerificationViewmodelBase, Store {
  late final _$secondsRemainingAtom = Atom(
      name: '_OTPVerificationViewmodelBase.secondsRemaining', context: context);

  @override
  int get secondsRemaining {
    _$secondsRemainingAtom.reportRead();
    return super.secondsRemaining;
  }

  @override
  set secondsRemaining(int value) {
    _$secondsRemainingAtom.reportWrite(value, super.secondsRemaining, () {
      super.secondsRemaining = value;
    });
  }

  late final _$isRetryAtom =
      Atom(name: '_OTPVerificationViewmodelBase.isRetry', context: context);

  @override
  bool get isRetry {
    _$isRetryAtom.reportRead();
    return super.isRetry;
  }

  @override
  set isRetry(bool value) {
    _$isRetryAtom.reportWrite(value, super.isRetry, () {
      super.isRetry = value;
    });
  }

  late final _$isPinCompAtom =
      Atom(name: '_OTPVerificationViewmodelBase.isPinComp', context: context);

  @override
  bool get isPinComp {
    _$isPinCompAtom.reportRead();
    return super.isPinComp;
  }

  @override
  set isPinComp(bool value) {
    _$isPinCompAtom.reportWrite(value, super.isPinComp, () {
      super.isPinComp = value;
    });
  }

  late final _$_OTPVerificationViewmodelBaseActionController =
      ActionController(name: '_OTPVerificationViewmodelBase', context: context);

  @override
  void changeRetryState(bool value) {
    final _$actionInfo = _$_OTPVerificationViewmodelBaseActionController
        .startAction(name: '_OTPVerificationViewmodelBase.changeRetryState');
    try {
      return super.changeRetryState(value);
    } finally {
      _$_OTPVerificationViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startTimer() {
    final _$actionInfo = _$_OTPVerificationViewmodelBaseActionController
        .startAction(name: '_OTPVerificationViewmodelBase.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_OTPVerificationViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendOtp() {
    final _$actionInfo = _$_OTPVerificationViewmodelBaseActionController
        .startAction(name: '_OTPVerificationViewmodelBase.sendOtp');
    try {
      return super.sendOtp();
    } finally {
      _$_OTPVerificationViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopTimer() {
    final _$actionInfo = _$_OTPVerificationViewmodelBaseActionController
        .startAction(name: '_OTPVerificationViewmodelBase.stopTimer');
    try {
      return super.stopTimer();
    } finally {
      _$_OTPVerificationViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementTimer() {
    final _$actionInfo = _$_OTPVerificationViewmodelBaseActionController
        .startAction(name: '_OTPVerificationViewmodelBase.decrementTimer');
    try {
      return super.decrementTimer();
    } finally {
      _$_OTPVerificationViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pinCompleted() {
    final _$actionInfo = _$_OTPVerificationViewmodelBaseActionController
        .startAction(name: '_OTPVerificationViewmodelBase.pinCompleted');
    try {
      return super.pinCompleted();
    } finally {
      _$_OTPVerificationViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
secondsRemaining: ${secondsRemaining},
isRetry: ${isRetry},
isPinComp: ${isPinComp}
    ''';
  }
}
