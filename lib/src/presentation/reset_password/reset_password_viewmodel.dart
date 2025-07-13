import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';

part 'reset_password_viewmodel.g.dart';

class ResetPasswordViewmodel = _ResetPasswordViewmodelBase with _$ResetPasswordViewmodel;

abstract class _ResetPasswordViewmodelBase with Store {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final GlobalKey<FormState> globalKey;

  @observable
  bool isValidate = false;

  @action
  void chechvalidate() {
    isValidate = globalKey.currentState?.validate() ?? false;
  }

  Future<void> submit() async {
    await Future<void>.delayed(Durations.medium2);
    router.goNamed(RoutePaths.congratulations.name);
  }
}
