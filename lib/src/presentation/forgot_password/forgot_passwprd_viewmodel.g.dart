// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_passwprd_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordViewmodel on _ForgotPasswordViewmodelBase, Store {
  late final _$selectedOptionAtom = Atom(
      name: '_ForgotPasswordViewmodelBase.selectedOption', context: context);

  @override
  String get selectedOption {
    _$selectedOptionAtom.reportRead();
    return super.selectedOption;
  }

  @override
  set selectedOption(String value) {
    _$selectedOptionAtom.reportWrite(value, super.selectedOption, () {
      super.selectedOption = value;
    });
  }

  late final _$isSubmittedAtom =
      Atom(name: '_ForgotPasswordViewmodelBase.isSubmitted', context: context);

  @override
  bool get isSubmitted {
    _$isSubmittedAtom.reportRead();
    return super.isSubmitted;
  }

  @override
  set isSubmitted(bool value) {
    _$isSubmittedAtom.reportWrite(value, super.isSubmitted, () {
      super.isSubmitted = value;
    });
  }

  late final _$isValidAtom =
      Atom(name: '_ForgotPasswordViewmodelBase.isValid', context: context);

  @override
  bool get isValid {
    _$isValidAtom.reportRead();
    return super.isValid;
  }

  @override
  set isValid(bool value) {
    _$isValidAtom.reportWrite(value, super.isValid, () {
      super.isValid = value;
    });
  }

  late final _$_ForgotPasswordViewmodelBaseActionController =
      ActionController(name: '_ForgotPasswordViewmodelBase', context: context);

  @override
  void setSelectedOption(String option) {
    final _$actionInfo = _$_ForgotPasswordViewmodelBaseActionController
        .startAction(name: '_ForgotPasswordViewmodelBase.setSelectedOption');
    try {
      return super.setSelectedOption(option);
    } finally {
      _$_ForgotPasswordViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSubmit() {
    final _$actionInfo = _$_ForgotPasswordViewmodelBaseActionController
        .startAction(name: '_ForgotPasswordViewmodelBase.onSubmit');
    try {
      return super.onSubmit();
    } finally {
      _$_ForgotPasswordViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedOption: ${selectedOption},
isSubmitted: ${isSubmitted},
isValid: ${isValid}
    ''';
  }
}
