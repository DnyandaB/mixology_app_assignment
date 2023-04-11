import 'package:login_demo/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:login_demo/core/networks/response_parser.dart';
import '../model/drinks_listing_model.dart';

abstract class GetDrinksListByCategoryDataSource {
  Future<Either<Failure, DrinksListingByCategoryModel>>
      callGetDrinksListByCategoryApi(String category);
}

class GetDrinksListByCategoryDataSourceImpl
    implements GetDrinksListByCategoryDataSource {
  ResponseParser responseParser;

  GetDrinksListByCategoryDataSourceImpl({required this.responseParser});

  @override
  Future<Either<Failure, DrinksListingByCategoryModel>>
      callGetDrinksListByCategoryApi(String category) async {
    var result = await responseParser.parseResponse(
        HttpMethodType.get, "filter.php?c=$category");
    if (result != null) {
      return result.fold((failure) {
        return Left(failure);
      }, (response) async {
        print(response.data);
        try {
          DrinksListingByCategoryModel model =
              DrinksListingByCategoryModel.fromJson(response.data);
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
