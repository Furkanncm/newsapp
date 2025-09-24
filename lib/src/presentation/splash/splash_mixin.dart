import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';
import 'package:newsapp/src/domain/country/country_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/splash/splash_view.dart';

mixin SplashMixin on State<SplashView> {
  double currentStep = 0;
  double previousStep = 0;
  late final CacheRepository _cacheRepository;
  late final IUserRepository _userRepository;
  late final ICountryRepository _countryRepository;
  late final AnimationController _animationController;
  late final Animation<double> fadeAnimation;
  late final Animation<double> scaleAnimation;
  late final Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    _cacheRepository = CacheRepository.instance;
    _userRepository = UserRepository();
    _countryRepository = CountryRepository();
    _animationController = AnimationController(
      vsync: this as TickerProvider,
      duration: const Duration(seconds: 1),
    );
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
    scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
    slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_animationController);

    // Animasyonu başlat
    _animationController.forward();

    _init();
  }

  Future<void> _incrementProgress() async {
    setState(() {
      previousStep = currentStep;
      currentStep += 1;
    });
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _init() async {
    await FirebaseDataSource().initialize();
    final isFirstTime = _cacheRepository.getBool(PrefKeys.isFirstTime);
    await _incrementProgress();
    final userId = _cacheRepository.getString(PrefKeys.isUserLoggedIn);
    await _incrementProgress();
    await checkUser(userId: userId);
    await _incrementProgress();
    await _incrementProgress();
    await fetchCountries();
    checkOnboard(isFirstTime ?? true);
    checkLogin(userId?.isNotEmpty, isFirstTime ?? true);
  }

  void checkOnboard(bool isFirstTime) {
    if (isFirstTime) {
      router.goNamed(RoutePaths.onboard.name);
    }
  }

  void checkLogin(bool? isLoggedIn, bool isFirstTime) {
    if (isFirstTime) return;
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
