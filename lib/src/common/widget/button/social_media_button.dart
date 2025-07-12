import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extension.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

@immutable
final class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: LuciText.bodyMedium(
            LocaleKeys.orContinueWith.tr(),
            textColor: AppTheme.surfaceDarkColor.withValues(alpha: 0.5),
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
              onPressed: () {},
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
