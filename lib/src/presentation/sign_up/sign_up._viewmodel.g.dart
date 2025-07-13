// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up._viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$SignUpViewmodel on _SignUpViewmodelBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid => (_$isFormValidComputed ??=
          Computed<bool>(() => super.isFormValid, name: '_SignUpViewmodelBase.isFormValid'))
      .value;

  late final _$isRememberMeAtom = Atom(name: '_SignUpViewmodelBase.isRememberMe', context: context);

  @override
  bool get isRememberMe {
    _$isRememberMeAtom.reportRead();
    return super.isRememberMe;
  }

  @override
  set isRememberMe(bool value) {
    _$isRememberMeAtom.reportWrite(value, super.isRememberMe, () {
      super.isRememberMe = value;
    });
  }

  late final _$isLoadingAtom = Atom(name: '_SignUpViewmodelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_SignUpViewmodelBaseActionController =
      ActionController(name: '_SignUpViewmodelBase', context: context);

  @override
  void toggleRememberMe() {
    final _$actionInfo = _$_SignUpViewmodelBaseActionController.startAction(
      name: '_SignUpViewmodelBase.toggleRememberMe',
    );
    try {
      return super.toggleRememberMe();
    } finally {
      _$_SignUpViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo =
        _$_SignUpViewmodelBaseActionController.startAction(name: '_SignUpViewmodelBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_SignUpViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isRememberMe: ${isRememberMe},
isLoading: ${isLoading},
isFormValid: ${isFormValid}
    ''';
  }
}
