import 'dart:async';

import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _currentStep = 0;
  double _previousStep = 0;
  late final CacheRepository _cacheRepository;

  @override
  void initState() {
    super.initState();
    _cacheRepository = CacheRepository.instance;
    _init();
  }

  Future<void> _incrementProgress() async {
    setState(() {
      _previousStep = _currentStep;
      _currentStep += 1;
    });
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _init() async {
    await _incrementProgress();
    await FirebaseDataSource.instance.initialize();
    await _incrementProgress();
    final userId = _cacheRepository.getString(PrefKeys.isUserLoggedIn);
    await _incrementProgress();

    checkLogin(userId?.isNotEmpty);
  }

  void checkLogin(bool? isLoggedIn) {
    if (isLoggedIn == true) {
      router.goNamed(RoutePaths.home.name);
    } else {
      router.goNamed(RoutePaths.login.name);
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
                tween: Tween<double>(
                  begin: _previousStep / 3,
                  end: _currentStep / 3,
                ),
                duration: const Duration(milliseconds: 300),
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
