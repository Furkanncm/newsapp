import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/localization/localization_repository.dart';
import 'package:newsapp/src/domain/theme/theme_repository.dart';

class AppConfiguration {
  AppConfiguration._init();
  static AppConfiguration? _instance;
  static AppConfiguration get instance {
    return _instance ??= AppConfiguration._init();
  }

  Future<void> appConfigurationReady() async {
    WidgetsFlutterBinding.ensureInitialized();
    await CacheRepository.instance.getInstance();
    ThemeRepository.instance.loadTheme();
    await EasyLocalization.ensureInitialized();
    runApp(
      EasyLocalization(
        supportedLocales: LocalizationManager.instance.supportedLocales,
        path: LocalizationManager.instance.path,
        fallbackLocale: LocalizationManager.instance.foolbackLocale,
        startLocale: LocalizationManager.instance.foolbackLocale,
        child: const NewsApp(),
      ),
    );
  }
}
