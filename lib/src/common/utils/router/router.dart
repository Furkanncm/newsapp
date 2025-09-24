import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/src/common/utils/enums/firebase_auth.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/widget/navigation_bar/bottom_navigationbar.dart';
import 'package:newsapp/src/common/widget/other/no_network_container.dart';
import 'package:newsapp/src/common/widget/other/topic_list_view.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/network_status/network_status.dart';
import 'package:newsapp/src/presentation/all_trends/all_trends_view.dart';
import 'package:newsapp/src/presentation/bookmark/bookmark_view.dart';
import 'package:newsapp/src/presentation/choose_country/choose_country_view.dart';
import 'package:newsapp/src/presentation/congratulations/congratulations_view.dart';
import 'package:newsapp/src/presentation/edit_profile/edit_profile_view.dart';
import 'package:newsapp/src/presentation/explore/explore_view.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_view.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_password_view.dart';
import 'package:newsapp/src/presentation/help/help_view.dart';
import 'package:newsapp/src/presentation/home/home_view.dart';
import 'package:newsapp/src/presentation/login/login_view.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_view.dart';
import 'package:newsapp/src/presentation/onboard/onboard_view.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_view.dart';
import 'package:newsapp/src/presentation/profile/profile_view.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_view.dart';
import 'package:newsapp/src/presentation/search/search_view.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_view.dart';
import 'package:newsapp/src/presentation/splash/splash_view.dart';
import 'package:newsapp/src/presentation/topic/topic_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final networkNotifier = NetworkStatusNotifier();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  refreshListenable: networkNotifier,
  initialLocation: RoutePaths.splash.path,
  routes: [
    GoRoute(
      path: RoutePaths.splash.path,
      name: RoutePaths.splash.name,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: RoutePaths.onboard.path,
      name: RoutePaths.onboard.name,
      builder: (context, state) => const OnboardView(),
    ),
    GoRoute(
      name: RoutePaths.login.name,
      path: RoutePaths.login.path,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      name: RoutePaths.signUp.name,
      path: RoutePaths.signUp.path,
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      name: RoutePaths.forgotPassword.name,
      path: RoutePaths.forgotPassword.path,
      builder: (context, state) => const ForgotPasswordView(),
    ),
    GoRoute(
      name: RoutePaths.otpVerification.name,
      path: RoutePaths.otpVerification.path,
      builder: (context, state) => const OtpVerificationView(),
    ),
    GoRoute(
      name: RoutePaths.resetPassword.name,
      path: RoutePaths.resetPassword.path,
      builder: (context, state) => const ResetPasswordView(),
    ),
    GoRoute(
      name: RoutePaths.congratulations.name,
      path: RoutePaths.congratulations.path,
      builder: (context, state) => const CongratulationsView(),
    ),
    GoRoute(
      name: RoutePaths.chooseCountry.name,
      path: RoutePaths.chooseCountry.path,
      builder: (context, state) => const ChooseCountryView(),
    ),
    GoRoute(
      name: RoutePaths.topics.name,
      path: RoutePaths.topics.path,
      builder: (context, state) => const TopicsView(),
    ),
    GoRoute(
      name: RoutePaths.fillProfile.name,
      path: RoutePaths.fillProfile.path,
      builder: (context, state) => const FillProfileView(),
    ),
    GoRoute(
      name: RoutePaths.searchPage.name,
      path: RoutePaths.searchPage.path,
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(
      name: RoutePaths.newsDetail.name,
      path: RoutePaths.newsDetail.path,
      builder: (context, state) => const NewsDetailView(),
    ),
    GoRoute(
      name: RoutePaths.editProfile.name,
      path: RoutePaths.editProfile.path,
      builder: (context, state) => const EditProfileView(),
    ),
    GoRoute(
      name: RoutePaths.help.name,
      path: RoutePaths.help.path,
      builder: (context, state) => const HelpView(),
    ),
    GoRoute(
      name: RoutePaths.exploreTopic.name,
      path: RoutePaths.exploreTopic.path,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: TopicListView()),
    ),
    GoRoute(
      name: RoutePaths.noNetwork.name,
      path: RoutePaths.noNetwork.path,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: NoNetworkContainer()),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppNavigationBar(child: child),
      routes: [
        GoRoute(
          path: RoutePaths.home.path,
          name: RoutePaths.home.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeView()),
          routes: [
            GoRoute(
              name: RoutePaths.allTrends.name,
              path: RoutePaths.allTrends.path,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AllTrendsView()),
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.explore.path,
          name: RoutePaths.explore.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ExploreView()),
        ),
        GoRoute(
          path: RoutePaths.bookmark.path,
          name: RoutePaths.bookmark.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: BookmarkView()),
        ),
        GoRoute(
          path: RoutePaths.profile.path,
          name: RoutePaths.profile.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileView()),
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final authStatus = AuthRepository().authStatus;
    final status = networkNotifier.value;
    if (status == NetworkStatus.off &&
        state.fullPath != RoutePaths.noNetwork.path) {
      return RoutePaths.noNetwork.path;
    }

    if (status == NetworkStatus.on &&
        state.fullPath == RoutePaths.noNetwork.path) {
      return RoutePaths.splash.path;
    }

    if (authStatus == FirebaseAuthEnum.unauthenticated) {}

    return null;
  },
);
