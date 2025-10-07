import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';

part 'reset_password_viewmodel.g.dart';

class ResetPasswordViewmodel = _ResetPasswordViewmodelBase
    with _$ResetPasswordViewmodel;

abstract class _ResetPasswordViewmodelBase with Store {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final GlobalKey<FormState> globalKey;
  late final IAuthRepository authRepository;

  @observable
  bool isValidate = false;

  @action
  void chechvalidate() {
    isValidate = globalKey.currentState?.validate() ?? false;
  }

  Future<void> submit(String email) async {
    await authRepository.resetPasswordWithEmail(email: email);
    router.goNamed(RoutePaths.congratulations.name);
  }
}
