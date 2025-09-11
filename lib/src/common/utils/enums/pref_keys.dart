enum PrefKeys {
  isOnboardActive('isOnboardActive'),
  themeCacheKey('ThemeCacheKey'),
  isUserLoggedIn('isUserLoggedIn');

  const PrefKeys(this.rawValue);
  final String rawValue;
}
