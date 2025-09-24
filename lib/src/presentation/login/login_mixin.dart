import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/src/common/utils/enums/pref_keys.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/data/data_source/local/local_ds.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';
import 'package:newsapp/src/presentation/login/login_view.dart';
import 'package:newsapp/src/presentation/login/login_viewmodel.dart';

mixin LoginMixin on State<LoginView> {
  late final LoginViewmodel viewModel;
  late final IUserRepository _userRepository;
  late final CacheRepository _cacheRepository;

  @override
  void initState() {
    super.initState();
    viewModel = LoginViewmodel();
    viewModel.formKey= GlobalKey<FormState>();
    viewModel.emailController= TextEditingController();
     viewModel.passwordController= TextEditingController();
    _userRepository = UserRepository();
    _cacheRepository = CacheRepository.instance;
  }

  bool get isFormValid => viewModel.isFormValid;
  bool get rememberMe => viewModel.isRememberMe;

  void toggleRememberMe() => viewModel.toggleRememberMe();

  Future<void> login() async {
    if (viewModel.formKey.currentState?.validate() ?? false) {
      await viewModel.login().withToast(
        context,
        successMessage: LocaleKeys.welcome_sincere.tr(),
        onSuccess: navigate,
      );
    }
  }

  Future<void> navigate() async {
    final userId = _cacheRepository.getString(PrefKeys.isUserLoggedIn);
    if (userId == null) return;
    await _userRepository.getUserInfo();
    if (_userRepository.currentUser?.isSkipped == true) {
      router.goNamed(RoutePaths.home.name);
    } else {
      router.goNamed(RoutePaths.topics.name);
    }
  }

  @override
  void dispose() {
   viewModel. emailController.dispose();
    viewModel.passwordController.dispose();
    super.dispose();
  }
}
