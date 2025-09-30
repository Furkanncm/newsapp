import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/otp_options_enum.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/verify_button.dart';
import 'package:newsapp/src/common/widget/text/label_with_star.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

@immutable
final class PhoneNumberTextfield extends StatefulWidget {
  const PhoneNumberTextfield({
    required this.phoneController,
    this.isForVerifyPhoneNumber = false,
    super.key,
  });

  final TextEditingController phoneController;
  final bool isForVerifyPhoneNumber;

  @override
  State<PhoneNumberTextfield> createState() => _PhoneNumberTextfieldState();
}

class _PhoneNumberTextfieldState extends State<PhoneNumberTextfield> {
  late final IUserRepository _userRepository;
  late final IAuthRepository _authRepository;
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
    _authRepository = AuthRepository();
    isVerified = _userRepository.currentUser?.isPhoneNumberVerified ?? false;
  }

  bool get checkValid => widget.phoneController.text.length == 14;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWithStar(isRequired: true, text: LocaleKeys.phoneNumber.tr()),
        verticalBox4,
        LuciPhoneTextFormField(
          fillColor: Theme.brightnessOf(context) == Brightness.light
              ? AppTheme.surfaceColor
              : AppTheme.bodyText,
          onChanged: (p0) => setState(() {}),
          controller: widget.phoneController,
          labelText: '',
          suffixIcon: VerifyButton(
            isValid: !widget.phoneController.text.isPhoneNumber,
            isVerified: isVerified,
            onPressed: () async {
              await _authRepository
                  .sendVerificationCodePhoneNumber(
                    model: OTPModel(
                      otpOptions: widget.isForVerifyPhoneNumber
                          ? OTPOptions.verifyWithNumber
                          : OTPOptions.sms,
                      otpContent: widget.phoneController.text,
                    ),
                  )
                  .withToast(context, successMessage: 'Code Send');
            },
          ),
        ),
      ],
    );
  }
}
