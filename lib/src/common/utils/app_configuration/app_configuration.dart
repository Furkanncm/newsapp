import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/localization/localization_repository.dart';

class AppConfiguration {
  AppConfiguration._init();
  static AppConfiguration? _instance;
  static AppConfiguration get instance {
    return _instance ??= AppConfiguration._init();
  }

  Future<void> appConfigurationReady() async {
    WidgetsFlutterBinding.ensureInitialized();
    await CacheRepository.instance.getInstance();
    await EasyLocalization.ensureInitialized();

    await Future.microtask(() {
      runApp(
        EasyLocalization(
          supportedLocales: LocalizationManager.instance.supportedLocales,
          path: LocalizationManager.instance.path,
          fallbackLocale: LocalizationManager.instance.foolbackLocale,
          startLocale: LocalizationManager.instance.foolbackLocale,
          child: const NewsApp(),
        ),
      );
    });
  }
}
