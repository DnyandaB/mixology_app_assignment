import 'package:dartz/dartz.dart';
import 'package:login_demo/core/failures/failures.dart';
import 'package:login_demo/feature/data/model/drinks_details_model.dart';
import 'package:login_demo/feature/data/remotedatasource/get_drinks_details_from_api.dart';
import 'package:login_demo/feature/domain/params/get_drink_details_params.dart';
import 'package:login_demo/feature/domain/repositories/get_drink_details_by_id.dart';

class GetDrinkDetailsByIdRepositoryImpl
    implements GetDrinkDetailsByIdRepository {
  GetDrinkDetailsByIdDataSource getDrinkDetailsByIdDataSource;

  GetDrinkDetailsByIdRepositoryImpl(
      {required this.getDrinkDetailsByIdDataSource});

  @override
  Future<Either<Failure, DrinkDetailsModel>> getDrinkDetailsById(
      DrinkDetailsParams drinkDetailsParams) {
    return getDrinkDetailsByIdDataSource
        .callGetDrinkDetailsByIdApi(drinkDetailsParams.drinkId);
  }
}
