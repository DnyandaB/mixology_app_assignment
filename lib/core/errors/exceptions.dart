class ServerException implements Exception {
  final msg;
  ServerException({this.msg});
}

class InternetException implements Exception {
  final msg;
  InternetException({this.msg});
}

class ClientException implements Exception {
  final msg;
  ClientException({this.msg});
}
