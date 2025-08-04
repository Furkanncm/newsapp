import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/sized_box/space_box.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/common/widget/other/no_network_container.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/localization/localization_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheRepository.instance.getInstance();
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

@immutable
final class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            child ?? emptyBox,
            const Positioned(bottom: 0, child: NoNetworkContainer()),
          ],
        );
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: LocaleKeys.appName.tr(),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
