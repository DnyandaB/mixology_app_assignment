import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:login_demo/core/errors/exceptions.dart';

import '../network_info/network_info.dart';

enum Environment { production, development, uat }

class BaseUrl {
  static var environment = Environment.development;

  static String getBaseUrl() {
    switch (environment) {
      case Environment.development:
        return "https://www.thecocktaildb.com/api/json/v1/1/";
      case Environment.uat:
        return "https://www.thecocktaildb.com/api/json/v1/1/";
      case Environment.production:
        return "";
      default:
        return "https://www.thecocktaildb.com/api/json/v1/1/";
    }
  }
}

Map<String, String> getHeader({bool requireToken = false, String? token}) {
  if (requireToken) {
    var header = {
      "content-type": "application/json",
      "authentication-token": token!,
    };
    print(header);
    return header;
  } else {
    return {
      "Accept": "*/*",
    };
  }
}

class NetworkHelper {
  final Dio dio;
  final NetworkInfo networkInfo;

  NetworkHelper({required this.dio, required this.networkInfo}) {
//  dio..interceptors.add(Intercept());
  }

  Future<Response?> get(String url) async {
    bool hasConnection = await networkInfo.currentNetworkConnection();
    if (hasConnection) {
      try {
        print("---------------------");
        print(url);
        print("---------------------");
        Response response = await dio.get(BaseUrl.getBaseUrl() + url);
        print(response.statusCode);
        if (response.statusCode == 200) {
          return response;
        } else {
          if (response.statusCode == 404) {
            throw ServerException(msg: "Data not found");
          } else {
            throw ServerException(msg: json.decode(response.data)["message"]);
          }
        }
      } catch (e) {
        if (e is DioError) {
          _dioError(e);
        }
        _error();
      }
    } else {
      _internetException();
    }
    return null;
  }

  Future<Response?> post(String url, dynamic body,
      {bool requireToken = false}) async {
    bool hasConnection = await networkInfo.currentNetworkConnection();
    if (hasConnection) {
    } else {
      _internetException();
    }
    return null;
  }

  Future<Response?> put(String url, dynamic body,
      {bool requireToken = false}) async {
    bool hasConnection = await networkInfo.currentNetworkConnection();
    if (hasConnection) {
      try {
        final response = await dio.put(BaseUrl.getBaseUrl() + url,
            data: body,
            options: Options(headers: getHeader(requireToken: requireToken)));
        print(response.statusCode);
        if (response.statusCode == 200) {
          if (response.data["status"] == 1) {
            print(response.data);
            print("---------------------");
            return response;
          } else {
            print(response.data);
            throw ServerException(msg: response.data["message"]);
          }
        } else {
          print(response.data);
          throw ServerException(msg: response.data["message"]);
        }
      } catch (e) {
        print(e.toString());
        if (e is DioError) {
          _dioError(e);
        }
        _error();
      }
    } else {
      _internetException();
    }
    return null;
  }

  void _error() {
    throw ServerException(msg: "Something went wrong");
  }

  void _internetException() {
    throw InternetException(msg: "No Internet");
  }

  void _dioError(DioError e) {
    if (e.response != null) {
      print(e.response!.statusCode);
      if (e.response!.statusCode == 404) {
        throw ServerException(msg: "Data not found");
      }
    } else {
      throw ServerException(msg: "Something went wrong");
    }
  }
}
