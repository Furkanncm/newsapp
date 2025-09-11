import 'package:codegen/codegen.dart';
import 'package:codegen/enum/category_enum.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
final class Topic extends Equatable implements BaseModel<Topic> {
  const Topic({
    this.value,
    @IconDataConverter() this.icon,
    this.description,
    this.isSaved,
    @ImageConverter() this.image,
  });

  @ImageConverter()
  @JsonKey(includeToJson: false, includeFromJson: false)
  final Image? image;
  final String? value;
  @IconDataConverter()
  @JsonKey(includeToJson: false, includeFromJson: false)
  final IconData? icon;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? description;
  final bool? isSaved;

  static final List<Topic> allTopics = [
    Topic(
      value: CategoryEnum.business.name,
      icon: Icons.business_center_outlined,
      description: CategoryEnum.business.nameToDescription,
      image: Assets.uiKitImages.icBusiness.toFit,
      isSaved: false,
    ),
    Topic(
      value: CategoryEnum.entertainment.name,
      icon: Icons.movie_filter_outlined,
      description: CategoryEnum.entertainment.nameToDescription,
      image: Assets.uiKitImages.icEntertainment.toFit,
      isSaved: false,
    ),
    Topic(
      value: CategoryEnum.general.name,
      icon: Icons.public,
      description: CategoryEnum.general.nameToDescription,
      image: Assets.uiKitImages.icGeneral.toFit,
      isSaved: false,
    ),
    Topic(
      value: CategoryEnum.health.name,
      icon: Icons.health_and_safety_outlined,
      description: CategoryEnum.health.nameToDescription,
      image: Assets.uiKitImages.icHealth.toFit,
      isSaved: false,
    ),
    Topic(
      value: CategoryEnum.science.name,
      icon: Icons.science_outlined,
      description: CategoryEnum.science.nameToDescription,
      image: Assets.uiKitImages.icScience.toFit,
      isSaved: false,
    ),
    Topic(
      value: CategoryEnum.sports.name,
      icon: Icons.sports_soccer_outlined,
      description: CategoryEnum.sports.nameToDescription,
      image: Assets.uiKitImages.icSports.toFit,
      isSaved: false,
    ),
    Topic(
      value: CategoryEnum.technology.name,
      icon: Icons.memory_outlined,
      description: CategoryEnum.technology.nameToDescription,
      image: Assets.uiKitImages.icTechnology.toFit,
      isSaved: false,
    ),
  ];

  @override
  List<Object?> get props => [value, icon, description, isSaved, image];

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TopicToJson(this);

  @override
  Topic fromJson(Map<String, Object?> json) => Topic.fromJson(json);

  Topic copyWith({
    String? value,
    IconData? icon,
    String? description,
    bool? isSaved,
    Image? image,
  }) {
    return Topic(
      value: value ?? this.value,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      isSaved: isSaved ?? this.isSaved,
      image: image ?? this.image,
    );
  }
}

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

class IconDataConverter implements JsonConverter<IconData, int> {
  const IconDataConverter();

  @override
  IconData fromJson(int json) => IconData(json, fontFamily: 'MaterialIcons');

  @override
  int toJson(IconData object) => object.codePoint;
}

class ImageConverter implements JsonConverter<Image?, String?> {
  const ImageConverter();

  @override
  Image? fromJson(String? json) =>
      json == null ? null : Image.asset(json, fit: BoxFit.cover);

  @override
  String? toJson(Image? object) {
    if (object is Image && object.image is AssetImage) {
      return (object.image as AssetImage).assetName;
    }
    return null;
  }
}
