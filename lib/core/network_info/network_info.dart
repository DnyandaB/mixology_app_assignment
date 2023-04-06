import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> currentNetworkConnection();
}

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity connectivity;
  final InternetConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(
      {required this.connectivity, required this.dataConnectionChecker});

  @override
  Future<bool> currentNetworkConnection() async {
    final connection = await dataConnectionChecker.hasConnection;
    return connection;
  }
}
