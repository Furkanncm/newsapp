enum OTPOptions {
  email('email'),
  sms('sms'),
  verifyWithNumber('verifyWithNumber');

  const OTPOptions(this.value);
  final String value;
}
