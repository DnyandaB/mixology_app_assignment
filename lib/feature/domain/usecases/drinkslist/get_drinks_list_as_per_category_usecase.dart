import 'package:login_demo/core/failures/failures.dart';
import 'package:login_demo/core/usecase/usecase.dart';
import 'package:login_demo/feature/domain/params/get_drinks_list_params.dart';
import 'package:login_demo/feature/domain/repositories/get_drinks_by_category_repository.dart';
import 'package:dartz/dartz.dart';

class GetDrinksListAsPerCategoryUseCase extends UseCase<Either<Failure, dynamic>, String>{

  final GetDrinksListByCategoryRepository getDrinksListByCategoryRepository;

  GetDrinksListAsPerCategoryUseCase({required this.getDrinksListByCategoryRepository});

  @override
  Future<Either<Failure, dynamic>> call(String param) async{
    GetDrinksListParams getDrinksListParams = GetDrinksListParams(categoryName: param);
    return await getDrinksListByCategoryRepository.getDrinksListAsPerCategory(getDrinksListParams);
  }
  
}