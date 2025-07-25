import 'package:flutter/material.dart';
import 'package:lucielle/widget/widget.dart';

abstract class LuciDialogs {
  static Future<void> showDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String positiveButtonLabel,
    required String negativeButtonLabel,
    required VoidCallback positiveButtonCallback,
    Color? dialogBackgroundColor,
    Color? primaryColor,
    bool? barrierDismissible,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) async {
    return showAdaptiveDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: dialogBackgroundColor,
          icon: CircleAvatar(
            backgroundColor: primaryColor ?? Colors.green,
            radius: 30,
            child: const Icon(
              Icons.question_mark_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          title: LuciText.titleMedium(
            title,
            fontWeight: FontWeight.bold,
          ),
          content: LuciText.bodyMedium(content),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LuciOutlinedButton(
                  borderSide: BorderSide(color: primaryColor ?? Colors.black),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: LuciText.bodyMedium(
                    negativeButtonLabel,
                    fontWeight: FontWeight.bold,
                    textColor: primaryColor,
                  ),
                ),
                horizontalBox8,
                LuciOutlinedButton(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    positiveButtonCallback();
                    Navigator.of(context).pop(false);
                  },
                  child: LuciText.bodyMedium(
                    positiveButtonLabel,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
