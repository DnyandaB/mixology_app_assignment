import 'package:login_demo/core/failures/failures.dart';
import 'package:login_demo/core/usecase/usecase.dart';
import 'package:login_demo/feature/data/model/drinks_details_model.dart';
import 'package:login_demo/feature/domain/repositories/get_drink_details_by_id.dart';

import '../../params/get_drink_details_params.dart';
import 'package:dartz/dartz.dart';

class GetDrinkDetailsAsPerIdUseCase
    extends UseCase<Either<Failure, DrinkDetailsModel>, String> {
  GetDrinkDetailsByIdRepository getDrinkDetailsByIdRepository;

  GetDrinkDetailsAsPerIdUseCase({required this.getDrinkDetailsByIdRepository});

  @override
  Future<Either<Failure, DrinkDetailsModel>> call(String param) {
    DrinkDetailsParams drinkDetailsParams = DrinkDetailsParams(drinkId: param);
    return getDrinkDetailsByIdRepository
        .getDrinkDetailsById(drinkDetailsParams);
  }
}
