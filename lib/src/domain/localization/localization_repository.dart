import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';
import 'package:newsapp/src/common/utils/enums/language_enum.dart';

class LocalizationManager {
  LocalizationManager._init();
  static LocalizationManager? _instance;
  static LocalizationManager get instance {
    return _instance ??= LocalizationManager._init();
  }

  final Locale _enLocale = const Locale(StringConstants.en, StringConstants.us);
  final Locale _trLocale = Locale(
    StringConstants.tr.toLowerCase(),
    StringConstants.tr,
  );
  List<Locale> get supportedLocales => [_enLocale, _trLocale];
  String get path => StringConstants.translationPath;
  Locale? get foolbackLocale => _enLocale;

  void changeLanguage({
    required BuildContext context,
    required LanguageEnum language,
  }) {
    switch (language) {
      case LanguageEnum.english:
       context.setLocale(_enLocale);
      case LanguageEnum.turkish:
        context.setLocale(_trLocale);
    }
  }
}
