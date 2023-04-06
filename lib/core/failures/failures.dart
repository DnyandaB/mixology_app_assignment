import 'package:flutter/cupertino.dart';

abstract class Failure {}

class ServerFailure extends Failure {
  final String failureType;
  ServerFailure({required this.failureType});
}

class ClientFailure extends Failure {
  final String failureType;
  ClientFailure({required this.failureType});
}

class NetworkFailure extends Failure {
  final String failureType;
  NetworkFailure({required this.failureType});
}
