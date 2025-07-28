import 'package:codegen/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/widget/other/news_info.dart';

@immutable
final class TrendNewsOnboard extends StatelessWidget {
  const TrendNewsOnboard({required this.onDetail, super.key});

  final VoidCallback onDetail;
  // final Source source;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDetail,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: context.height * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Assets.images.onboard1.toFit,
            ),
          ),
          verticalBox4,
          // Source paslanıcak.
          const NewsInfo(
            region: 'Europe',
            title: 'Russian warship: Moskva sinks in Black Sea',
            source: 'BBC News',
            pastTime: '4h ago',
          ),
          verticalBox16,
        ],
      ),
    );
  }
}
