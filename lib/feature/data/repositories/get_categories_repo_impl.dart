import 'package:dartz/dartz.dart';
import 'package:login_demo/core/failures/failures.dart';
import 'package:login_demo/feature/data/model/category_model.dart';
import 'package:login_demo/feature/data/remotedatasource/get_categories_from_api.dart';
import 'package:login_demo/feature/domain/repositories/get_categories_repository.dart';

class GetCategoryRepositoryImpl implements GetCategoryRepository {
  GetCategoriesDatasource getCategoriesDatasource;

  GetCategoryRepositoryImpl({required this.getCategoriesDatasource});

  @override
  Future<Either<Failure, CategoryListModel>> getCategoryList() {
    return getCategoriesDatasource.getCategoriesApi();
  }
}
