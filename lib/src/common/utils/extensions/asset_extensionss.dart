import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension AssetGenImageExtension on AssetGenImage {
  Image get toImage => image(package: LocaleKeys.packageName.tr());
  Image get toImageWithSize =>
      image(width: 24, height: 24, package: LocaleKeys.packageName.tr());
  Image toIcon(double iconSize) => image(
    width: iconSize,
    height: iconSize,
    package: LocaleKeys.packageName.tr(),
  );

  Image get toFit =>
      image(fit: BoxFit.cover, package: LocaleKeys.packageName.tr());
}
