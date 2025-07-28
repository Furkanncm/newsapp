import 'package:codegen/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';

@immutable
final class SourceAndAgoWidget extends StatelessWidget {
  const SourceAndAgoWidget({
    required this.source,
    required this.pastTime,
    super.key,
  });

  //final Source source;
  final String source;
  final String pastTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LuciText.bodySmall(source, fontWeight: FontWeight.w500),
        horizontalBox20,
        Assets.uiKitImages.icSendOutline.toIcon(16),
        horizontalBox4,
        LuciText.bodySmall(pastTime),
        const Spacer(),
        Assets.uiKitImages.icMoreHorOutline.toIcon(16),
      ],
    );
  }
}
