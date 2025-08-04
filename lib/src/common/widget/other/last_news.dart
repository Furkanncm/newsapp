import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/lucielle.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';
import 'package:newsapp/src/common/widget/other/news_info.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';

@immutable
final class LastNews extends StatelessWidget {
  const LastNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: NaPadding.verticalPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Assets.images.onboard3.toFit,
            ),
          ),
          horizontalBox12,
          const Expanded(
            child: NewsInfo(
              region: 'Europe',
              title:
                  "Ukraine's President Zelensky to BBC: Blood money being paid lorem ipsum lorem ipsum",
              source: 'BBC News',
              pastTime: '14m ago',
            ),
          ),
        ],
      ),
    );
  }
}
