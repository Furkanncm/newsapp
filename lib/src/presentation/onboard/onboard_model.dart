import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/src/common/utils/extensions/asset_extensionss.dart';

final class OnboardModel {
  OnboardModel({this.image, this.header, this.description});
  final Widget? image;
  final String? header;
  final String? description;

  static List<OnboardModel> get getItems {
    return [
      OnboardModel(
        image: Assets.images.onboard1.toImage,
        header: LocaleKeys.bitcoinHeader.tr(),
        description: LocaleKeys.bitcoinDescription.tr(),
      ),
      OnboardModel(
        image: Assets.images.onboard2.toImage,
        header: LocaleKeys.tourismHeader.tr(),
        description: LocaleKeys.tourismDescription.tr(),
      ),
      OnboardModel(
        image: Assets.images.onboard3.toImage,
        header: LocaleKeys.foodHeader.tr(),
        description: LocaleKeys.foodDescription.tr(),
      ),
    ];
  }
}
