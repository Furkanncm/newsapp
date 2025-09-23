enum PrefKeys {
  isFirstTime('isFirstTime'),
  themeCacheKey('ThemeCacheKey'),
  isUserLoggedIn('isUserLoggedIn');

  const PrefKeys(this.rawValue);
  final String rawValue;
}
