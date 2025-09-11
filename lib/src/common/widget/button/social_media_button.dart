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
import 'package:newsapp/src/data/data_source/remote/firebase_ds.dart';
import 'package:newsapp/src/domain/user/user_repository.dart';

@immutable
final class SocialMediaLogin extends StatelessWidget {
  SocialMediaLogin({super.key});

  final IFirebaseDataSource _firebaseDataSource = FirebaseDataSource.instance;
  final IUserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    Future<void> loginWithGoogle() async {
      await _firebaseDataSource.loginWithGoogle().withToast(
        context,
        successMessage: LocaleKeys.welcome_sincere.tr(),
        onSuccess: () async {
          final user = await _userRepository.getUserInfo();
          if (user?.isSkipped == true) {
            router.goNamed(RoutePaths.home.name);
          } else {
            router.goNamed(RoutePaths.topics.name);
          }
        },
      );
    }

    return Column(
      children: [
        Center(
          child: LuciText.bodyMedium(
            LocaleKeys.orContinueWith.tr(),
            textColor: AppTheme.placeholder,
          ),
        ),
        verticalBox16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LuciOutlinedButton(
              child: Assets.images.icFacebook.toImageWithSize,
              onPressed: () {},
            ),
            horizontalBox4,
            LuciOutlinedButton(
              onPressed: loginWithGoogle,
              child: Assets.images.icGoogle.toImageWithSize,
            ),
            horizontalBox4,
            LuciOutlinedButton(
              child: Assets.images.icApple.toImageWithSize,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
