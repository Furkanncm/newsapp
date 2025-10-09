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
    String? successMessage,
    Future<void> Function()? onSuccess,
    bool showSuccessToast = true,
  }) async {
    final result = await this.withIndicator(context);
    if (!context.mounted) return result;
    if (result != null && result.succeeded == true) {
      if (showSuccessToast) {
        NewsAppSnackBar.show(
          context: context,
          text: successMessage ?? result.messages?.firstOrNull ?? '',
          type: SnackBarType.info,
        );
      }

      await onSuccess?.call();
    } else {
      NewsAppSnackBar.show(
        context: context,
        text: result?.messages?.firstOrNull ?? '',
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
    if (context.mounted) router.pop();
    return result;
  }
}

extension FutureXAll<T> on Future<T> {
  Future<T> withLoading({
    required BuildContext context,
    String? successMessage,
    Future<void> Function(T value)? onSuccess,
    bool showSuccessToast = true,
  }) async {
    if (!context.mounted) return this;

    final dialogFuture = showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(),
    );

    final result = await this;

    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (successMessage != null && context.mounted) {
      if (showSuccessToast) {
        NewsAppSnackBar.show(
          context: context,
          text: showSuccessToast ? successMessage : '',
          type: SnackBarType.info,
        );
      }
    }
    if (onSuccess != null) await onSuccess(result);

    await dialogFuture;

    return result;
  }
}
