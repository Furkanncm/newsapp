enum RoutePaths {
  splash('/'),
  onboard('/onboard'),
  login('/login'),
  signUp('/signUp'),
  forgotPassword('/forgotPassword'),
  otpVerification('/otpVerification'),
  resetPassword('/resetPassword'),
  congratulations('/congratulations'),
  chooseCountry('/chooseCountry'),
  topics('/topic'),
  fillProfile('/fillProfile'),
  editProfile('/editProfile'),
  home('/home'),
  explore('/explore'),
  bookmark('/bookmark'),
  profile('/profile'),
  allTrends('/allTrends'),
  allLastest('/allLastest'),
  searchPage('/searchPage'),
  exploreTopic('/exploreTopic'),
  newsDetail('/news-detail'),
  newsList('/news-list'),
  help('/help');

  const RoutePaths(this.path);
  final String path;
}
