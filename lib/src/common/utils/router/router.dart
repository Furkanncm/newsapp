import 'package:go_router/go_router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/data/enums/pref_keys.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/presentation/choose_country/view/choose_country_view.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_password_view.dart';
import 'package:newsapp/src/presentation/login/login_view.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_view.dart';
import 'package:newsapp/src/presentation/onboard/onboard_view.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_view.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_view.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_view.dart';

final GoRouter router = GoRouter(
  initialLocation: RoutePaths.onboard.path,
  routes: [
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
      name: RoutePaths.chooseCountry.name,
      path: RoutePaths.chooseCountry.path,
      builder: (context, state) => const ChooseCountryView(),
    ),
    GoRoute(
      path: RoutePaths.home.path,
      name: RoutePaths.home.name,
      builder: (context, state) => const NewsDetailView(),
    ),
  ],
  redirect: (context, state) {
    final isOnboardActive = CacheRepository.instance.getBool(PrefKeys.isOnboardActive);
    if (!(isOnboardActive ?? true)) return RoutePaths.chooseCountry.path;
    return null;
  },
);
