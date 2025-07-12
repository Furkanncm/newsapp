import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/constants/view_constants.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/model/otp_model.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_mixin.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});
  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> with OtTPVerificationMixin {
  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as OTPModel?;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: ViewConstants.instance.pagePadding,
          child: Align(
            child: Column(
              children: [
                LuciText.headlineSmall('OTP Verification', fontWeight: FontWeight.bold),
                verticalBox16,
                LuciText.bodyLarge('Enter the OTP sent to ${extra?.otpContent}'),
                verticalBox24,
                PinCodeTextField(
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
                  errorAnimationController: viewmodel.errorController,
                  controller: viewmodel.pinCodeController,
                  backgroundColor: Colors.white,
                  onCompleted: (v) {},
                  onChanged: (value) {
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
                verticalBox16,
                Observer(
                  builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LuciText.bodyLarge('Resend code in '),
                        GestureDetector(
                          onTap: viewmodel.isRetry ? () => viewmodel.sendOtp() : null,
                          child: LuciText.bodyLarge(
                            viewmodel.isRetry ? 'retry' : '${viewmodel.secondsRemaining}s',
                            textColor: AppTheme.errorColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
