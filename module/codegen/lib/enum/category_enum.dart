enum CategoryEnum {
  business('Business'),
  entertainment('Entertainment'),
  general('General'),
  health('Health'),
  science('Science'),
  sports('Sports'),
  technology('Technology'); 

  const CategoryEnum(this.value);
  final String value;

  String get  nameToDescription {
    switch (this) {
      case CategoryEnum.business:
        return 'Latest updates from the world of business and finance.';
      case CategoryEnum.entertainment:
        return 'News about movies, TV shows, music, and celebrities.';
      case CategoryEnum.general:
        return 'Top headlines and general news stories.';
      case CategoryEnum.health:
        return 'News about health, wellness, and medical discoveries.';
      case CategoryEnum.science:
        return 'Scientific breakthroughs, space exploration, and research.';
      case CategoryEnum.sports:
        return 'Latest scores, highlights, and updates from the sports world.';
      case CategoryEnum.technology:
        return 'News about the latest gadgets, apps, and tech trends.';
    }
  }
}
