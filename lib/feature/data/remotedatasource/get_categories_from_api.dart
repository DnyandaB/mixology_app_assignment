
import 'package:login_demo/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:login_demo/core/networks/response_parser.dart';
import 'package:login_demo/feature/data/model/category_model.dart';

abstract class GetCategoriesDatasource {
  Future<Either<Failure,CategoryListModel>> getCategoriesApi();
}

class GetCategoriesDatasourceImpl implements GetCategoriesDatasource{
  ResponseParser responseParser;
  GetCategoriesDatasourceImpl({required this.responseParser});

  @override
  Future<Either<Failure,CategoryListModel>> getCategoriesApi() async {
    var result  = await responseParser.parseResponse(HttpMethodType.get, "list.php?c=list");
    if(result != null){
      return result.fold((failure){
        return Left(failure);
      }, (response) async {
        print(response.data);
        try{
          CategoryListModel model = CategoryListModel.fromJson(response.data);
          return Right(model);
        }catch(e){
          return Left(ClientFailure(failureType: 'Something Went Wrong'));
        }

      });
    }else{
      return Left(ServerFailure(failureType: 'Something Went Wrong'));
    }
  }
}