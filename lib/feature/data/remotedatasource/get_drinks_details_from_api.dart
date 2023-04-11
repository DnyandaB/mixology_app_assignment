import 'package:login_demo/core/failures/failures.dart';
import 'package:login_demo/core/networks/response_parser.dart';

import '../model/drinks_details_model.dart';
import 'package:dartz/dartz.dart';

abstract class GetDrinkDetailsByIdDataSource {
  Future<Either<Failure, DrinkDetailsModel>> callGetDrinkDetailsByIdApi(
      String drinkId);
}

class GetDrinkDetailsByIdDataSourceImpl
    implements GetDrinkDetailsByIdDataSource {
  ResponseParser responseParser;

  GetDrinkDetailsByIdDataSourceImpl({required this.responseParser});

  @override
  Future<Either<Failure, DrinkDetailsModel>> callGetDrinkDetailsByIdApi(
      String drinkId) async {
    final result = await responseParser.parseResponse(
        HttpMethodType.get, "lookup.php?i=$drinkId");
    if (result != null) {
      return result.fold((failure) {
        return Left(failure);
      }, (response) async {
        print(response.data);
        try {
          DrinkDetailsModel model = DrinkDetailsModel.fromJson(response.data);
          return Right(model);
        } catch (e) {
          return Left(ClientFailure(failureType: 'Something Went Wrong'));
        }
      });
    } else {
      return Left(ServerFailure(failureType: 'Something Went Wrong'));
    }
  }
}
