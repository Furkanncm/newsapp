class Validator {
  const Validator._();

  static String? isEmptyOrNull(String? value, String? label) {
    return value == null || value.isEmpty ? '$label value is can not be null' : null;
  }
}
