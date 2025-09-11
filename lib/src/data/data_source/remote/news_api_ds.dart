import 'dart:io';

import 'package:codegen/codegen.dart';
import 'package:codegen/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/constants/string_constants.dart';
import 'package:newsapp/src/common/utils/enums/env_enum.dart';
import 'package:newsapp/src/common/utils/enums/remote_ds_path.dart';

abstract class INewsApiDS {}

class NewsApiDs {
  NewsApiDs() {
    dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env[EnvEnum.baseUrl.value]!,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  late final Dio dio;
  late final _apiKey = dotenv.env[EnvEnum.apiKey.value]!;

  Future<NetworkResponse<T>> fetch<T>({
    required RemoteDsPath path,
    required Map<String, dynamic> queryParameters,
  }) async {
    final queryParams = {
      StringConstants.queryParamsKeys: _apiKey,
      ...queryParameters,
    };
    final result = await dio.get(path.value, queryParameters: queryParams);
    switch (result.statusCode) {
      case HttpStatus.ok:
        final jsonBody = result.data;
        if (jsonBody is Map<String, dynamic>) {
          final baseData = News.fromJson(jsonBody);
          return NetworkResponse.success(data: baseData as T);
        } else {
          return NetworkResponse.success(data: jsonBody as T);
        }

      default:
        return NetworkResponse.failure(
          message: result.statusMessage ?? LocaleKeys.unknownError.tr(),
        );
    }
  }
}
