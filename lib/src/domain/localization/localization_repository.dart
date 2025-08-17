import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';

class LocalizationManager {
  LocalizationManager._init();
  static LocalizationManager? _instance;
  static LocalizationManager get instance {
    return _instance ??= LocalizationManager._init();
  }

  final Locale _enLocale = const Locale(StringConstants.en, StringConstants.en);
  final Locale _trLocale = const Locale(StringConstants.tr, StringConstants.tr);
  List<Locale> get supportedLocales => [_enLocale, _trLocale];
  String get path => StringConstants.translationPath;
  Locale? get foolbackLocale => _enLocale;
}
