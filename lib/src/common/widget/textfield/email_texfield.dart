import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/widget/button/verify_button.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

@immutable
final class EmailTextField extends StatefulWidget {
  const EmailTextField({
    required this.emailController,
    this.readOnly = false,
    super.key,
  });

  final TextEditingController emailController;
  final bool readOnly;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late final TextEditingController _emailController;
  late final IAuthRepository _authRepository;
  late final IUserRepository _userRepository;

  late final ValueNotifier<bool?> isVerifiedNotifier;

  @override
  void initState() {
    super.initState();
    _emailController = widget.emailController;
    _authRepository = AuthRepository();
    _userRepository = UserRepository();
    isVerifiedNotifier = ValueNotifier(_userRepository.isEmailVerified);
  }

  @override
  Widget build(BuildContext context) {
    return LuciEmailTextFormField(
      controller: _emailController,
      labelText: '',
      readOnly: widget.readOnly,
      suffixIcon: ValueListenableBuilder<bool?>(
        valueListenable: isVerifiedNotifier,
        builder: (context, isVerified, child) {
          return VerifyButton(
            isValid: !_emailController.text.isEmail,
            isVerified: isVerified,
            onPressed: () async {
              await _authRepository
                  .sendVerificationEmail()
                  .withIndicator(context)
                  .withToast(
                    context,
                    successMessage:
                        'Please check your email: ${_emailController.text}',
                    onSuccess: () {
                      return _userRepository.updateProfile(
                        user: _userRepository.currentUser!.copyWith(
                          isEmailVerified: true,
                        ),
                      );
                    },
                  );

              isVerifiedNotifier.value = _userRepository.isEmailVerified;
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    isVerifiedNotifier.dispose();
    super.dispose();
  }
}
