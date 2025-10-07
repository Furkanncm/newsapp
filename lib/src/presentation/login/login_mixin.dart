import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/login/login_view.dart';
import 'package:newsapp/src/presentation/login/login_viewmodel.dart';

mixin LoginMixin on State<LoginView> {
  late final LoginViewmodel viewModel;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewmodel();
    _initController();
    _initRepositories();
  }

  bool get isFormValid => formKey.currentState?.validate() ?? false;

  Future<void> login() async {
    if (isFormValid) {
      await viewModel
          .login(email: emailController.text, password: passwordController.text)
          .withToast(
            context,
            successMessage: LocaleKeys.welcome_sincere.tr(),
            onSuccess: navigate,
          );
    }
  }

  Future<void> navigate() async {
    final userId = viewModel.cacheRepository.getString(PrefKeys.isUserLoggedIn);
    if (userId == null) return;
    await viewModel.userRepository.getUserInfo();
    if (viewModel.userRepository.currentUser?.isSkipped == true) {
      router.goNamed(RoutePaths.home.name);
    } else {
      router.goNamed(RoutePaths.topics.name);
    }
  }

  void _initController() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _initRepositories() {
    viewModel.authRepository = AuthRepository();
    viewModel.userRepository = UserRepository();
    viewModel.cacheRepository = CacheRepository.instance;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
