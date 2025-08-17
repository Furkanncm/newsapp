import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/enums/snackbar_enum.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/snackbar/snackbar.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/login/login_view.dart';
import 'package:newsapp/src/presentation/login/login_viewmodel.dart';

mixin LoginMixin on State<LoginView> {
  late final LoginViewmodel viewModel;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final IUserRepository _userRepository;
  late final CacheRepository _cacheRepository;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewmodel();
    formKey = viewModel.formKey;
    emailController = viewModel.emailController;
    passwordController = viewModel.passwordController;
    _userRepository = UserRepository();
    _cacheRepository = CacheRepository.instance;
  }

  bool get isFormValid => viewModel.isFormValid;
  bool get rememberMe => viewModel.isRememberMe;

  void toggleRememberMe() => viewModel.toggleRememberMe();

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      final result = await viewModel.login();
      if (result != null && result.succeeded == true) {
        NewsAppSnackBar.show(
          context: context,
          text: '${LocaleKeys.loggedInAs.tr()} ${_userRepository.getUserEmail}',
          type: SnackBarType.info,
        );

        navigate();
      } else {
        NewsAppSnackBar.show(
          context: context,
          text: result?.messages?.first ?? '',
          type: SnackBarType.error,
        );
      }
    }
  }

  void navigate() {
    if (_cacheRepository.getBool(PrefKeys.isTopicSkipped) == true) {
      router.goNamed(RoutePaths.home.name);
    } else {
      router.goNamed(RoutePaths.topics.name);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
