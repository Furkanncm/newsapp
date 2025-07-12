import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';

class LocalizationManager {
  LocalizationManager._init();
  static LocalizationManager? _instance;
  static LocalizationManager get instance {
    return _instance ??= LocalizationManager._init();
  }

  final Locale _enLocale = Locale(StringConstants.en.name, StringConstants.en.value);
  final Locale _trLocale =  Locale(StringConstants.tr.name,StringConstants.tr.value);
  List<Locale> get supportedLocales => [_enLocale, _trLocale];
  String get path => StringConstants.translationPath.value;
  Locale? get foolbackLocale => _enLocale;
}
