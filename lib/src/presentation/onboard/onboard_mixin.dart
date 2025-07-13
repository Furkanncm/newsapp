import 'package:flutter/material.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/enums/pref_keys.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/presentation/onboard/onboard_model.dart';
import 'package:newsapp/src/presentation/onboard/onboard_view.dart';

mixin OnboardMixin on State<OnboardView> {
  List<OnboardModel> get onboardList => OnboardModel.getItems;
  PageController pageController = PageController();
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);
  int get currentPage => currentPageNotifier.value;
  ValueNotifier<bool> isFirstPage = ValueNotifier(true);
  ValueNotifier<bool> isLastPage = ValueNotifier(false);
  final ValueNotifier<bool> isDontShowAgain = ValueNotifier(false);
  bool get isDontShowAgainValue => isDontShowAgain.value;

  @override
  void initState() {
    super.initState();
    print(isDontShowAgainValue);
    setIsOnboardActive(true);
  }

  Future<void> setIsOnboardActive(bool isActivated) async {
    await CacheRepository.instance.setBool(PrefKeys.isOnboardActive, isActivated);
  }

  void pageChanged(int value) {
    currentPageNotifier.value = value;
    isFirstPage.value = currentPage == 0;
    isLastPage.value = currentPage == onboardList.length - 1;
  }

  void nextPage() {
    if (currentPage == onboardList.length - 1) {
      router.pushReplacementNamed(RoutePaths.login.name);
      if (isDontShowAgainValue == true) setIsOnboardActive(false);
    }
    if (currentPage < onboardList.length - 1) {
      pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void backPage() {
    if (currentPage > 0) {
      pageController.animateToPage(
        currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void dontShowAgain(bool? value) {
    isDontShowAgain.value = value ?? false;
    setIsOnboardActive(!isDontShowAgain.value);
    print(isDontShowAgain);
  }
}
