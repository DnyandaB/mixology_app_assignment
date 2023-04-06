import 'package:login_demo/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:login_demo/feature/data/model/category_model.dart';

abstract class GetCategoryRepository {
 Future<Either<Failure, CategoryListModel>> getCategoryList();
}