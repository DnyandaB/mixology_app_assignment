

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login_demo/core/errors/exceptions.dart';
import 'package:login_demo/core/networks/networks_helper.dart';


import '../failures/failures.dart';

enum HttpMethodType { get}

class ResponseParser {
  NetworkHelper? helper;

  ResponseParser({required this.helper});

  Future<Either<Failure,Response>?> parseResponse(HttpMethodType methodType, String urlEndpoint) async {
    switch (methodType) {
      case HttpMethodType.get:
        try{
          Response? data = await helper!.get(urlEndpoint);
          if(data != null){
            return Right(data);
          }else{
            return Left(NetworkFailure(failureType: "Something went wrong"));
          }
        }catch(e){
          if(e is ServerException){
            return Left(ServerFailure(failureType: e.msg));
          }
          if(e is InternetException){
            return Left(NetworkFailure(failureType: "No Internet"));
          }
        }
        break;
    }
    return null;
  }
}
