import 'package:codegen/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucielle/utils/extensions/extensions.dart';
import 'package:lucielle/widget/widget.dart';
import 'package:newsapp/src/common/widget/padding/na_padding.dart';
import 'package:newsapp/src/domain/network_status/network_status.dart';

class NoNetworkContainer extends StatefulWidget {
  const NoNetworkContainer({super.key});

  @override
  State<NoNetworkContainer> createState() => _NoNetworkContainerState();
}

class _NoNetworkContainerState extends State<NoNetworkContainer>
    with NetworkMixin {
  late final INetworkStatusManager _networkStatusManager;
  NetworkStatus? networkStatus;

  @override
  void initState() {
    super.initState();
    _networkStatusManager = NetworkStatusManager();
    _networkStatusManager.checkNetworkFirstTime();
    init();
  }

  Future<void> init() async {
    safeDraw(() {
      _networkStatusManager.handleNetworkStatus((NetworkStatus status) {
        if (mounted) {
          setState(() {
            networkStatus = status;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _networkStatusManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      secondCurve: Curves.bounceInOut,
      duration: Durations.long2,
      firstChild: Padding(
        padding: NaPadding.elevatedButtonPadding,
        child: SafeArea(
          child: Container(
            height: context.height * 0.045,
            width: context.width * 0.91,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                horizontalBox8,
                const Icon(Icons.wifi_off, color: Colors.white),
                horizontalBox8,
                Padding(
                  padding: NaPadding.elevatedButtonPadding,
                  child: Text(
                    LocaleKeys.noConnection.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      secondChild: const SizedBox.shrink(),
      crossFadeState: networkStatus == NetworkStatus.off
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
    );
  }
}

mixin NetworkMixin<T extends StatefulWidget> on State<T> {
  void safeDraw(VoidCallback onComplete) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onComplete.call();
    });
  }
}
