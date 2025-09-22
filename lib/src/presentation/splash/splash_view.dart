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
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _currentStep = 0;
  double _previousStep = 0;
  late final CacheRepository _cacheRepository;
  late final IUserRepository _userRepository;
  late final ICountryRepository _countryRepository;

  @override
  void initState() {
    super.initState();
    _cacheRepository = CacheRepository.instance;
    _userRepository = UserRepository();
    _countryRepository = CountryRepository();
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
    await FirebaseDataSource.instance.initialize();
    final isOnboardActive = _cacheRepository.getBool(PrefKeys.isOnboardActive);
    await _incrementProgress();
    final userId = _cacheRepository.getString(PrefKeys.isUserLoggedIn);
    await _incrementProgress();
    await checkUser(userId: userId);
    await _incrementProgress();
    await _incrementProgress();
    await fetchCountries();
    checkOnboard(isOnboardActive ?? false);
    checkLogin(userId?.isNotEmpty, isOnboardActive ?? false);
  }

  void checkOnboard(bool isOnboardActive) {
    if (isOnboardActive) {
      router.goNamed(RoutePaths.onboard.name);
    }
  }

  void checkLogin(bool? isLoggedIn, bool isOnboardActive) {
    if (isOnboardActive) return;
    if (isLoggedIn == true) {
      router.goNamed(RoutePaths.home.name);
    } else {
      router.goNamed(RoutePaths.login.name);
    }
  }

  Future<void> checkUser({required String? userId}) async {
    if (userId == null) return;
    await _userRepository.getUserInfo();
  }

  Future<void> fetchCountries() async {
    await _countryRepository.getCountries();
    
    _countryRepository.getFiltersCountry();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Assets.images.icAppLogo.toImage),
        bottomNavigationBar: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 12,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: _previousStep / 5,
                      end: _currentStep / 5,
                    ),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        backgroundColor: AppTheme.buttonText.withValues(
                          alpha: 0.2,
                        ),
                        color: AppTheme.primaryColor,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
