import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

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
  Future<void> init();
  void disposeNotifier();
  late final Connectivity connectivity;
  StreamSubscription<List<ConnectivityResult>>? subscription;
}

class NetworkStatusNotifier extends ValueNotifier<NetworkStatus>
    implements INetworkStatusManager {
  NetworkStatusNotifier() : super(NetworkStatus.on) {
    connectivity = Connectivity();
    init();
  }

  @override
  late final Connectivity connectivity;
  @override
  StreamSubscription<List<ConnectivityResult>>? subscription;

  @override
  Future<void> init() async {
    final first = await connectivity.checkConnectivity();
    value = NetworkStatus.checkNetworkResult(first);

    subscription = connectivity.onConnectivityChanged.listen((results) {
      value = NetworkStatus.checkNetworkResult(results);
    });
  }

  @override
  void disposeNotifier() {
    subscription?.cancel();
    super.dispose();
  }
}
