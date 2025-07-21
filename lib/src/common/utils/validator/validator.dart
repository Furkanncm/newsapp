import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Validator {
  const Validator._();

  static String? isEmptyOrNull(String? value, String? label) {
    return value == null || value.isEmpty ? '$label ${LocaleKeys.again.tr()}' : null;
  }
}
