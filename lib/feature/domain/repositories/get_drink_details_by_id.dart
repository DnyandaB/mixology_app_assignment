import 'package:login_demo/core/failures/failures.dart';
import 'package:login_demo/feature/data/model/drinks_details_model.dart';
import 'package:dartz/dartz.dart';

import '../params/get_drink_details_params.dart';

abstract class GetDrinkDetailsByIdRepository{
  Future<Either<Failure, DrinkDetailsModel>> getDrinkDetailsById(DrinkDetailsParams drinkDetailsParams);
}