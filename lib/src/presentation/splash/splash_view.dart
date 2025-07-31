import 'dart:async';

import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/enums/pref_keys.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? timer;
  final Duration _duration = const Duration(milliseconds: 250);
  double _progress = 0;
  @override
  void initState() {
    super.initState();
    timerStart();
  }

  void timerStart() {
    timer = Timer.periodic(_duration, (timer) {
      _progress = _progress + (1 / 8);
      setState(() {});
      if (timer.tick == 8) {
        timer.cancel();
        navigate();
      }
    });
  }

  Future<void> navigate() async {
    final isOnboardActive = CacheRepository.instance.getBool(PrefKeys.isOnboardActive);
    if (isOnboardActive == false) {
      router.goNamed(RoutePaths.home.name);
    } else {
      router.goNamed(RoutePaths.onboard.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Assets.images.icAppLogo.toImage),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 12,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _progress),
                duration: const Duration(milliseconds: 100),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: AppTheme.buttonText.withValues(alpha: 0.2),
                    color: AppTheme.primaryColor,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
