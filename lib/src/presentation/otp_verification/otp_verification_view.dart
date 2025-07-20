import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
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

class _OtpVerificationViewState extends State<OtpVerificationView> with OtTPVerificationMixin {
  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as OTPModel?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: router.pop,
        ),
      ),
      body: _Body(extra: extra, viewmodel: viewmodel),
      bottomNavigationBar: Observer(
        builder: (_) {
          return NewsBottomButton(
            text: viewmodel.isRetry ? LocaleKeys.resendCodeIn.tr() : LocaleKeys.verify.tr(),
            onPressed: viewmodel.isRetry
                ? viewmodel.sendOtp
                : viewmodel.isPinComp
                    ? verify
                    : null,
          );
        },
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.extra,
    required this.viewmodel,
  });

  final OTPModel? extra;
  final OTPVerificationViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: ViewConstants.instance.pagePadding,
        child: Align(
          child: Column(
            children: [
              LuciText.headlineSmall(LocaleKeys.otpVerification.tr(), fontWeight: FontWeight.bold),
              verticalBox16,
              LuciText.bodyLarge('${LocaleKeys.enterOtpSentTo.tr()} ${extra?.otpContent}'),
              verticalBox24,
              PinField(viewmodel: viewmodel),
              verticalBox16,
              _ResendCode(viewmodel: viewmodel),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class PinField extends StatefulWidget {
  const PinField({
    required this.viewmodel,
    super.key,
  });
  final OTPVerificationViewmodel viewmodel;
  @override
  State<PinField> createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return PinCodeTextField(
          keyboardType: TextInputType.number,
          length: 6,
          appContext: context,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 60,
            fieldWidth: 50,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveColor: Colors.grey,
            selectedColor: AppTheme.primaryColor,
            activeColor: Colors.black,
            errorBorderColor: AppTheme.errorColor,
          ),
          animationDuration: const Duration(milliseconds: 300),
          errorAnimationController: widget.viewmodel.errorController,
          controller: widget.viewmodel.pinCodeController,
          backgroundColor: AppTheme.buttonBackground,
          enabled: !widget.viewmodel.isRetry,
          onCompleted: (v) async {
            widget.viewmodel.pinCompleted();
          },
          onChanged: (value) {
            setState(() {});
          },
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
  const _ResendCode({
    required this.viewmodel,
  });

  final OTPVerificationViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LuciText.bodyLarge(LocaleKeys.resendCodeIn.tr()),
            LuciText.bodyLarge(
              '${viewmodel.secondsRemaining}s',
              textColor: AppTheme.errorColor,
            ),
          ],
        );
      },
    );
  }
}
