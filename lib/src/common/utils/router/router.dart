import 'package:go_router/go_router.dart';
import 'package:newsapp/src/data/enums/route_paths.dart';
import 'package:newsapp/src/presentation/choose_country/choose_country_view.dart';
import 'package:newsapp/src/presentation/congratulations/congratulations_view.dart';
import 'package:newsapp/src/presentation/fill_profile/fill_profile_view.dart';
import 'package:newsapp/src/presentation/forgot_password/forgot_password_view.dart';
import 'package:newsapp/src/presentation/login/login_view.dart';
import 'package:newsapp/src/presentation/news_detail/news_detail_view.dart';
import 'package:newsapp/src/presentation/onboard/onboard_view.dart';
import 'package:newsapp/src/presentation/otp_verification/otp_verification_view.dart';
import 'package:newsapp/src/presentation/reset_password/reset_password_view.dart';
import 'package:newsapp/src/presentation/sign_up/sign_up_view.dart';
import 'package:newsapp/src/presentation/splash/splash_view.dart';
import 'package:newsapp/src/presentation/topic/topic_view.dart';

final GoRouter router = GoRouter(
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
      path: RoutePaths.home.path,
      name: RoutePaths.home.name,
      builder: (context, state) => const NewsDetailView(),
    ),
  ],
);
