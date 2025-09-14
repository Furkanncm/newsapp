import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/utils/theme/app_theme.dart';

class NoNetworkContainer extends StatefulWidget {
  const NoNetworkContainer({super.key});
  @override
  State<NoNetworkContainer> createState() => _NoNetworkContainerState();
}

class _NoNetworkContainerState extends State<NoNetworkContainer>
    with NetworkMixin {
  _NoNetworkContainerState();

  @override
  Widget build(BuildContext context) {
    return const NoNetworkPage();
  }
}

mixin NetworkMixin<T extends StatefulWidget> on State<T> {
  void safeDraw(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onComplete.call();
    });
  }
}

class NoNetworkPage extends StatelessWidget {
  const NoNetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.noConntection.toImage,
            verticalBox8,
            LuciText.headlineSmall(
              LocaleKeys.noNetwork_title,
              textColor: AppTheme.warningColor,
            ),
            verticalBox12,
            LuciText.labelMedium(
              LocaleKeys.noNetwork_subtitle1,
              textColor: AppTheme.placeholder,
            ),
            verticalBox4,
            LuciText.labelMedium(
              LocaleKeys.noNetwork_subtitle2,
              textColor: AppTheme.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
