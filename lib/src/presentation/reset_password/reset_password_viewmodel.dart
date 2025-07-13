import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'reset_password_viewmodel.g.dart';

class ResetPasswordViewmodel = _ResetPasswordViewmodelBase with _$ResetPasswordViewmodel;

abstract class _ResetPasswordViewmodelBase with Store {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
}
