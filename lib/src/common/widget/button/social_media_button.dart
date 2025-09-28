import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/enums/route_paths.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/utils/extensions/future_extension.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';
import 'package:newsapp/src/domain/auth_repository/auth_repository.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

@immutable
final class SocialMediaLogin extends StatefulWidget {
  const SocialMediaLogin({super.key});

  @override
  State<SocialMediaLogin> createState() => _SocialMediaLoginState();
}

class _SocialMediaLoginState extends State<SocialMediaLogin> {
  late final IAuthRepository _authRepository;

  late final IUserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository();
    _userRepository = UserRepository();
  }

  Future<void> _succesRoute() async {
    final user = await _userRepository.getUserInfo();
    if (user?.isSkipped == true) {
      router.goNamed(RoutePaths.home.name);
    } else {
      router.goNamed(RoutePaths.topics.name);
    }
  }

  Future<void> loginWithGoogle() async {
    await _authRepository.loginWithGoogle().withToast(
      context,
      successMessage: LocaleKeys.welcome_sincere.tr(),
      onSuccess: _succesRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(child: Divider()),
            horizontalBox4,
            LuciText.bodyMedium(
              LocaleKeys.orContinueWith.tr(),
              textColor: AppTheme.placeholder,
            ),
            horizontalBox4,
            const Expanded(child: Divider()),
          ],
        ),
        verticalBox32,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LuciOutlinedButton.icon(
              borderColor: Theme.brightnessOf(context) == Brightness.light
                  ? AppTheme.inputDark
                  : AppTheme.bodyText,
              borderRadius: BorderRadius.circular(16),
              icon: Assets.images.icGoogle.toIcon(32),
              onPressed: loginWithGoogle,
              child: Center(
                child: LuciText.bodyMedium(
                  LocaleKeys.continueWithGoogle.tr(),
                  textColor: Theme.brightnessOf(context) == Brightness.light
                      ? AppTheme.inputDark
                      : AppTheme.bodyDark,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
