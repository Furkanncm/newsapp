import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/data/model/otp_model.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key});
  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as OTPModel?;
    return Scaffold(
      appBar: AppBar(
        title: Text(extra?.otpContent ?? ''),
      ),
    );
  }
}
