import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../data/model/category_model.dart';
import '../../repositories/get_categories_repository.dart';

class GetCategoryListUsecase extends TypeUseCase<Either<Failure, CategoryListModel>> {
  final GetCategoryRepository getCategoryRepository;

  GetCategoryListUsecase({required this.getCategoryRepository});

  @override
  Future<Either<Failure, CategoryListModel>> call() async {
    return await getCategoryRepository.getCategoryList();
  }
}
