import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/data/model/otp/otp_model.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_mixin.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

@immutable
final class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});
  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView>
    with OtTPVerificationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: router.pop,
        ),
      ),
      body: _Body(
        extra: extra,
        viewmodel: viewmodel,
        onVerify: onVerifyPressed,
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.extra,
    required this.viewmodel,
    required this.onVerify,
  });

  final OTPModel? extra;
  final OTPVerificationViewmodel viewmodel;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: NaPadding.pagePadding,
        child: Align(
          child: Column(
            children: [
              LuciText.headlineSmall(
                LocaleKeys.otpVerification.tr(),
                fontWeight: FontWeight.bold,
              ),
              verticalBox16,
              LuciText.bodyLarge(
                '${LocaleKeys.enterOtpSentTo.tr()}${extra?.otpContent}',
              ),
              verticalBox24,
              PinField(viewmodel: viewmodel, onVerify: onVerify),
              verticalBox16,
              _ResendCode(viewmodel: viewmodel, extra: extra!),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class PinField extends StatefulWidget {
  const PinField({required this.viewmodel, required this.onVerify, super.key});
  final OTPVerificationViewmodel viewmodel;
  final VoidCallback onVerify;
  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Observer(
      builder: (_) {
        return PinCodeTextField(
          keyboardType: TextInputType.number,
          length: 6,
          appContext: context,
          animationType: AnimationType.fade,
          pinTheme: AppPinTheme(context: context).pinTheme,
          animationDuration: const Duration(milliseconds: 300),
          errorAnimationController: widget.viewmodel.errorController,
          controller: widget.viewmodel.pinCodeController,
          backgroundColor: isLightTheme
              ? AppTheme.buttonBackground
              : AppTheme.backgroundDark,
          enabled: !widget.viewmodel.isRetry,
          onCompleted: (v) => widget.onVerify.call(),
          beforeTextPaste: (text) {
            return true;
          },
        );
      },
    );
  }
}

@immutable
final class _ResendCode extends StatelessWidget {
  const _ResendCode({required this.viewmodel, required this.extra});

  final OTPVerificationViewmodel viewmodel;
  final OTPModel extra;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Observer(
      builder: (_) {
        return Visibility(
          visible: viewmodel.secondsRemaining != 0,
          replacement: Align(
            child: LuciOutlinedButton(
              onPressed: () => viewmodel.authRepository
                  .sendVerificationCodePhoneNumber(model: extra),
              child: LuciText.bodyMedium(
                LocaleKeys.sendCodeAgain.tr(),
                textColor: isLightTheme ? AppTheme.bodyText : AppTheme.bodyDark,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LuciText.bodyLarge(LocaleKeys.resendCodeIn.tr()),
              LuciText.bodyLarge(
                '${viewmodel.secondsRemaining}s',
                textColor: AppTheme.errorColor,
              ),
            ],
          ),
        );
      },
    );
  }
}

final class AppPinTheme {
  final BuildContext context;
  late final bool isLightTheme;

  AppPinTheme({required this.context}) {
    isLightTheme = Theme.of(context).brightness == Brightness.light;
  }

  PinTheme get pinTheme => PinTheme(
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(8),
    fieldHeight: 50,
    fieldWidth: 50,
    activeFillColor: isLightTheme ? AppTheme.surfaceColor : AppTheme.inputDark,
    inactiveFillColor: isLightTheme
        ? AppTheme.surfaceColor
        : AppTheme.inputDark,
    selectedFillColor: isLightTheme
        ? AppTheme.surfaceColor
        : AppTheme.inputDark,
    inactiveColor: isLightTheme ? AppTheme.buttonText : AppTheme.bodyDark,
    selectedColor: AppTheme.primaryColor,
    activeColor: isLightTheme ? AppTheme.backgroundDark : AppTheme.surfaceColor,
    errorBorderColor: AppTheme.errorColor,
  );
}
