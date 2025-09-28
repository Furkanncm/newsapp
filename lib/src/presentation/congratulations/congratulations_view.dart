import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/widget/button/bottom_button.dart';
import 'package:newsapp/src/presentation/congratulations/congratulations_mixin.dart';

class CongratulationsView extends StatelessWidget with CongratulationsMixin {
  const CongratulationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalBox64,
            Assets.images.icAppLogo.toImage,
            verticalBox64,
            LuciText.headlineSmall(LocaleKeys.congratulations_title.tr()),
            verticalBox4,
            LuciText.bodyLarge(LocaleKeys.congratulations_subtitle.tr()),
          ],
        ),
      ),
      bottomNavigationBar: NewsBottomButton(
        text: LocaleKeys.yes.tr(),
        onPressed: routeHomePage,
      ),
    );
  }
}
