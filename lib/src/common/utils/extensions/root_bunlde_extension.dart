extension RootBunldeExtension on String {
  String get _assetPath => 'assets/country/$this';
  String get toJson => '$_assetPath.json';
}
