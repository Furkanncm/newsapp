import 'package:newsapp/src/data/enums/otp_options_enum.dart';

class OTPModel {
  OTPModel({
    required this.otpOptions,
    required this.otpContent,
  });
  final OTPOptions otpOptions;
  final String otpContent;
}
