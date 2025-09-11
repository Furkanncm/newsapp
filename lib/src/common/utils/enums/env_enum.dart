import 'package:newsapp/src/common/utils/constants/string_constants.dart';

enum EnvEnum { apiKey, baseUrl }

extension EnvExtension on EnvEnum {
  String get value {
    switch (this) {
      case EnvEnum.apiKey:
        return StringConstants.newsApiKey;
      case EnvEnum.baseUrl:
        return StringConstants.baseUrl;
    }
  }
}
