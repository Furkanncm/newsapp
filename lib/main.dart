import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/app_configuration/app_configuration.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/domain/theme/theme_repository.dart';

Future<void> main() async {
  await AppConfiguration.instance.appConfigurationReady();
}

@immutable
final class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: ThemeRepository.instance.themeNotifier,
      builder: (context, theme, _) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          title: StringConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: router,
        );
      },
    );
  }
}
