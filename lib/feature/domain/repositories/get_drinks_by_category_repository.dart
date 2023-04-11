import 'package:dartz/dartz.dart';
import 'package:login_demo/core/failures/failures.dart';
import 'package:login_demo/feature/data/model/drinks_listing_model.dart';

import '../params/get_drinks_list_params.dart';

abstract class GetDrinksListByCategoryRepository{
 Future<Either<Failure, DrinksListingByCategoryModel>> getDrinksListAsPerCategory(GetDrinksListParams getDrinksListParams);
}