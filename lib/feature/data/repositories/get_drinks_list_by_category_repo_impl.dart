import 'package:dartz/dartz.dart';

import 'package:login_demo/core/failures/failures.dart';

import 'package:login_demo/feature/data/model/drinks_listing_model.dart';

import '../../domain/params/get_drinks_list_params.dart';
import '../../domain/repositories/get_drinks_by_category_repository.dart';
import '../remotedatasource/get_drinks_list_by_category.dart';

class GetDrinksListByCategoryRepositoryImpl implements GetDrinksListByCategoryRepository{
  GetDrinksListByCategoryDataSource getDrinksListByCategoryDataSource;
  GetDrinksListByCategoryRepositoryImpl({required this.getDrinksListByCategoryDataSource});

  @override
  Future<Either<Failure, DrinksListingByCategoryModel>> getDrinksListAsPerCategory(GetDrinksListParams getDrinksListParams) {
    return getDrinksListByCategoryDataSource.callGetDrinksListByCategoryApi(getDrinksListParams.categoryName);
  }
}