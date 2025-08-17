enum PrefKeys {
  isOnboardActive('isOnboardActive'),
  themeCacheKey('ThemeCacheKey'),
  isUserLoggedIn('isUserLoggedIn'),
  isTopicSkipped('isTopicSkipped');

  const PrefKeys(this.rawValue);
  final String rawValue;
}
