// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

class $AssetsCountryGen {
  const $AssetsCountryGen();

  /// File path: assets/country/countries.json
  String get countries => 'assets/country/countries.json';

  /// List of all assets
  List<String> get values => [countries];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// File path: assets/translations/tr-TR.json
  String get trTR => 'assets/translations/tr-TR.json';

  /// List of all assets
  List<String> get values => [enUS, trTR];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsCountryGen country = $AssetsCountryGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}
