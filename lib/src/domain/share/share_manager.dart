import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';

class ShareManager {
  ShareManager._();

  static ShareManager? _instance;

  static ShareManager get instance {
    _instance ??= ShareManager._();
    return _instance!;
  }

  Future<ShareResultStatus> shareNewsLink(String url) async {
    final result = await SharePlus.instance.share(
      ShareParams(
        uri: Uri.parse(url),
        subject: LocaleKeys.subjectShare.tr(),
        title: LocaleKeys.titleShare.tr(),
      ),
    );
    return result.status;
  }
}
