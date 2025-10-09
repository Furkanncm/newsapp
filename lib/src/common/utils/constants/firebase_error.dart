import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';

final class FirebaseError {
  FirebaseError._();

  static NetworkResponse<T> errorInfo<T>(FirebaseAuthException e) {
    return NetworkResponse<T>(
      data: null,
      messages: [switchErrorMessageHandling(e)],
      statusCode: e.code.toIntOrNull(),
      succeeded: false,
    );
  }

  static String switchErrorMessageHandling(FirebaseAuthException e) {
    switch (e.code) {
      case StringConstants.userNotFound:
        return LocaleKeys.userNotFound.tr();
      case StringConstants.wrongPassword:
        return LocaleKeys.wrongPassword.tr();
      case StringConstants.invalidEmail:
        return LocaleKeys.invalidEmail.tr();
      case StringConstants.userDisabled:
        return LocaleKeys.userDisabled.tr();
      case StringConstants.emailAlreadyInUse:
        return LocaleKeys.emailAlreadyInUse.tr();
      case StringConstants.weakPassword:
        return LocaleKeys.weakPassword.tr();
      case StringConstants.operationNotAllowed:
        return LocaleKeys.operationNotAllowed.tr();
      case StringConstants.tooManyRequests:
        return LocaleKeys.tooManyRequests.tr();
      case StringConstants.networkRequestFailed:
        return LocaleKeys.networkRequestFailed.tr();
      case StringConstants.invalidCredential:
        return LocaleKeys.invalidCredential.tr();
      case StringConstants.invalidVerificationCode:
        return LocaleKeys.invalidVerificationCode.tr();
      case StringConstants.invalidVerificationId:
        return LocaleKeys.invalidVerificationId.tr();
      case StringConstants.missingVerificationCode:
        return LocaleKeys.missingVerificationCode.tr();
      case StringConstants.missingVerificationId:
        return LocaleKeys.missingVerificationId.tr();
      case StringConstants.sessionExpired:
        return LocaleKeys.sessionExpired.tr();
      case StringConstants.captchaCheckFailed:
        return LocaleKeys.captchaCheckFailed.tr();
      case StringConstants.quotaExceeded:
        return LocaleKeys.quotaExceeded.tr();
      case StringConstants.appNotAuthorized:
        return LocaleKeys.appNotAuthorized.tr();
      case StringConstants.missingPhoneNumber:
        return LocaleKeys.missingPhoneNumber.tr();
      case StringConstants.invalidPhoneNumber:
        return LocaleKeys.invalidPhoneNumber.tr();
      case StringConstants.unverifiedEmail:
        return LocaleKeys.unverifiedEmail.tr();
      case StringConstants.invalidAppCredential:
        return LocaleKeys.invalidAppCredential.tr();
      case StringConstants.credentialAlreadyInUse:
        return LocaleKeys.credentialAlreadyInUse.tr();
      default:
        return LocaleKeys.unknownError.tr();
    }
  }
}
