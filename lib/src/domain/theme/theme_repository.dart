import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';

class ThemeRepository {
  ThemeRepository._();

  static ThemeRepository? _instance;
  static ThemeRepository get instace => _instance ??= ThemeRepository._();

  final CacheRepository _repository = CacheRepository.instance;

  final ValueNotifier<ThemeData> themeNotifier = ValueNotifier(
    AppTheme.lightTheme,
  );

  void setTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.dark) {
      themeNotifier.value = AppTheme.lightTheme;
      _repository.setBool(PrefKeys.themeCacheKey, false);
    } else {
      themeNotifier.value = AppTheme.darkTheme;
      _repository.setBool(PrefKeys.themeCacheKey, true);
    }
  }

  void loadTheme() {
    final result = _repository.getBool(PrefKeys.themeCacheKey);
    if (result == null) return;
    themeNotifier.value = result ? AppTheme.darkTheme : AppTheme.lightTheme;
  }
}
