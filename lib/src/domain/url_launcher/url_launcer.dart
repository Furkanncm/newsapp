import 'package:url_launcher/url_launcher_string.dart';

class LuciUrlLauncher {
  LuciUrlLauncher._();

  static LuciUrlLauncher? _instance;
  static LuciUrlLauncher get instance {
    _instance ??= LuciUrlLauncher._();
    return _instance!;
  }

  /// Instagram Profili Aç
  Future<void> launchURL({
    required String appUrl,
    required String webUrl,
  }) async {
    if (await canLaunchUrlString(appUrl)) {
      await launchUrlString(appUrl, mode: LaunchMode.externalApplication);
    } else {
      await launchUrlString(webUrl, mode: LaunchMode.externalApplication);
    }
  }
}
