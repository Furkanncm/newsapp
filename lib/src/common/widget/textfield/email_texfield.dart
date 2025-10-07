import 'dart:async';

import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/verify_button.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

@immutable
final class EmailTextField extends StatefulWidget {
  const EmailTextField({
    required this.emailController,
    this.readOnly = false,
    this.isForVerify = true,
    this.onPressed,
    super.key,
  });

  final TextEditingController emailController;
  final bool readOnly;
  final bool isForVerify;
  final VoidCallback? onPressed;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  late final TextEditingController _emailController;
  late final IAuthRepository _authRepository;
  late final IUserRepository _userRepository;

  late final ValueNotifier<bool?> isVerifiedNotifier;
  Timer? _verificationCheckTimer;

  @override
  void initState() {
    super.initState();
    _emailController = widget.emailController;
    _authRepository = AuthRepository();
    _userRepository = UserRepository();

    isVerifiedNotifier = ValueNotifier(
      _userRepository.firebaseUser?.emailVerified ?? false,
    );

    if (!(isVerifiedNotifier.value ?? false)) {
      _startVerificationChecker();
    }
  }

  void _startVerificationChecker() {
    _verificationCheckTimer = Timer.periodic(const Duration(seconds: 5), (
      _,
    ) async {
      final isVerified = await _checkEmailVerified();
      if (isVerified) {
        isVerifiedNotifier.value = true;
        _verificationCheckTimer?.cancel();
      }
    });
  }

  Future<bool> _checkEmailVerified() async {
    final user = _authRepository.firebaseUser;
    if (user == null) return false;
    await user.reload();
    return user.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    return LuciEmailTextFormField(
      controller: _emailController,
      labelText: '',
      readOnly: widget.readOnly,
      fillColor: Theme.brightnessOf(context) == Brightness.light
          ? AppTheme.surfaceColor
          : AppTheme.bodyText,
      suffixIcon: !widget.isForVerify
          ? emptyBox
          : ValueListenableBuilder<bool?>(
              valueListenable: isVerifiedNotifier,
              builder: (context, isVerified, child) {
                return ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _emailController,
                  builder: (context, value, _) {
                    return VerifyButton(
                      label: widget.isForVerify
                          ? LocaleKeys.verify.tr()
                          : LocaleKeys.verifyCodeSent.tr(),
                      isValid: !_emailController.text.isEmail,
                      isVerified: isVerified,
                      onPressed: () async => widget.onPressed?.call(),
                    );
                  },
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    isVerifiedNotifier.dispose();
    _verificationCheckTimer?.cancel();
    super.dispose();
  }
}
