import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus {
  on,
  off;

  static NetworkStatus checkNetworkResult(
    List<ConnectivityResult> connectivityResults,
  ) {
    if (connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.ethernet) ||
        connectivityResults.contains(ConnectivityResult.vpn) ||
        connectivityResults.contains(ConnectivityResult.bluetooth)) {
      return NetworkStatus.on;
    }

    return NetworkStatus.off;
  }
}

typedef NetworkCallback = void Function(NetworkStatus result);

abstract class INetworkStatusManager {
  Future<NetworkStatus> checkNetworkFirstTime();
  void handleNetworkStatus(NetworkCallback onChange);
  void dispose();
}

class NetworkStatusManager implements INetworkStatusManager {
  NetworkStatusManager() {
    _connectivity = Connectivity();
  }
  late final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  Future<NetworkStatus> checkNetworkFirstTime() async {
    final connectivityResults = await _connectivity.checkConnectivity();
    return NetworkStatus.checkNetworkResult(connectivityResults);
  }

  @override
  void handleNetworkStatus(NetworkCallback onChange) {
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      onChange.call(NetworkStatus.checkNetworkResult(result));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}
