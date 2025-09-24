import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/widget/button/verify_button.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';

class EmailTextField extends StatefulWidget {
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

  late final ValueNotifier<bool?> isVerifiedNotifier;

  @override
  void initState() {
    super.initState();
    _emailController = widget.emailController;
    _authRepository = AuthRepository();

    isVerifiedNotifier = ValueNotifier(_authRepository.isVerified);
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
              await _authRepository.sendVerificationEmail();
              isVerifiedNotifier.value = _authRepository.isVerified;
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
