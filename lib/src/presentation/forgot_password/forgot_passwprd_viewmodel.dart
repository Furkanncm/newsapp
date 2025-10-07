import 'package:mobx/mobx.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';

part 'forgot_passwprd_viewmodel.g.dart';

class ForgotPasswordViewmodel = _ForgotPasswordViewmodelBase
    with _$ForgotPasswordViewmodel;

abstract class _ForgotPasswordViewmodelBase with Store {
  late final IAuthRepository authRepository;

  Future<void> resetPasswordWithEmail(String email) async {
    await authRepository.resetPasswordWithEmail(email: email);
  }
}
