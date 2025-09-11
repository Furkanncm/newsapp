import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/src/common/base/base_response.dart';
import 'package:newsapp/src/common/utils/enums/snackbar_enum.dart';
import 'package:newsapp/src/common/utils/router/router.dart';
import 'package:newsapp/src/common/utils/snackbar/snackbar.dart';
import 'package:newsapp/src/common/widget/other/loading_dialog.dart';

extension FutureX<T> on Future<NetworkResponse<T>?> {
  Future<NetworkResponse<T>?> withToast(
    BuildContext context, {
    required String successMessage,
    Future<void> Function()? onSuccess,
  }) async {
    final result = await this.withIndicator(context);
    if (!context.mounted) return result;
    if (result != null && result.succeeded == true) {
      NewsAppSnackBar.show(
        context: context,
        text: successMessage,
        type: SnackBarType.info,
      );

      await onSuccess?.call();
    } else {
      NewsAppSnackBar.show(
        context: context,
        text: result?.messages?.first ?? '',
        type: SnackBarType.error,
      );
    }
    return result;
  }

  Future<NetworkResponse<T>?> withIndicator(BuildContext context) async {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingDialog(),
      ),
    );

    final result = await this;
    router.pop();
    return result;
  }
}
