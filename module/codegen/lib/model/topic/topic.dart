import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Topic extends Equatable {
  const Topic({
    required this.value,
    required this.icon,
    required this.description,
    required this.isSaved,
    this.image,
  });

  final Image? image;
  final String value;
  final IconData icon;
  final String description;
  final bool isSaved;

  static final List<Topic> allTopics = [
    const Topic(
      value: 'All',
      icon: Icons.done_all_outlined,
      description: 'All news topics combined in one place.',
      isSaved: false,
    ),
    Topic(
      value: 'Business',
      icon: Icons.business_center_outlined,
      description: 'Latest updates from the world of business and finance.',
      image: Assets.uiKitImages.icBusiness.toFit,
      isSaved: false,
    ),
    Topic(
      value: 'Entertainment',
      icon: Icons.movie_filter_outlined,
      description: 'News about movies, TV shows, music, and celebrities.',
      image: Assets.uiKitImages.icEntertainment.toFit,
      isSaved: false,
    ),
    Topic(
      value: 'General',
      icon: Icons.public,
      description: 'Top headlines and general news stories.',
      image: Assets.uiKitImages.icGeneral.toFit,
      isSaved: false,
    ),
    Topic(
      value: 'Health',
      icon: Icons.health_and_safety_outlined,
      description: 'News about health, wellness, and medical discoveries.',
      image: Assets.uiKitImages.icHealth.toFit,
      isSaved: false,
    ),
    Topic(
      value: 'Science',
      icon: Icons.science_outlined,
      description: 'Scientific breakthroughs, space exploration, and research.',
      image: Assets.uiKitImages.icScience.toFit,
      isSaved: false,
    ),
    Topic(
      value: 'Sports',
      icon: Icons.sports_soccer_outlined,
      description:
          'Latest scores, highlights, and updates from the sports world.',
      image: Assets.uiKitImages.icSports.toFit,
      isSaved: false,
    ),
    Topic(
      value: 'Technology',
      icon: Icons.memory_outlined,
      description: 'News about the latest gadgets, apps, and tech trends.',
      image: Assets.uiKitImages.icTechnology.toFit,
      isSaved: false,
    ),
  ];

  @override
  List<Object?> get props => [value, icon, description, isSaved, image];

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
