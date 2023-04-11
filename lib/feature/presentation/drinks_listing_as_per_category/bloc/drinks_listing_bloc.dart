import '../../../../core/failures/failures.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/drinks_listing_model.dart';
import '../../../domain/usecases/drinkslist/get_drinks_list_as_per_category_usecase.dart';

import 'package:rxdart/rxdart.dart';

import '../../common_widgets/toast_message.dart';

class FetchDrinksListingBloc{
  GetDrinksListAsPerCategoryUseCase getDrinksListAsPerCategoryUseCase;

  FetchDrinksListingBloc({required this.getDrinksListAsPerCategoryUseCase});

  ///error
  final errorStreamController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get errorStream => errorStreamController.stream;

  ///loader
  final loaderStreamController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loaderStream => loaderStreamController.stream;

  final drinksListAsPerCategoryListStreamController =
      BehaviorSubject<DrinksListingByCategoryModel?>.seeded(null);

  Stream<DrinksListingByCategoryModel?> get drinksListAsPerCategoryListStream =>
      drinksListAsPerCategoryListStreamController.stream;

  showLoader({required bool value}) {
    loaderStreamController.add(value);
  }

  fetchDrinksListAsPerCategoryCategories(String categoryName) async {
    errorStreamController.add(false);
    showLoader(value: true);
    var result = await getDrinksListAsPerCategoryUseCase.call(categoryName);
    showLoader(value: false);
    result.fold((failure) {
      errorStreamController.add(true);
      if (failure is ServerFailure) {
        ToastMessage.show(failure.failureType);
      }
      if (failure is ClientFailure) {
        ToastMessage.show(failure.failureType);
      }
      if (failure is NetworkFailure) {
        ToastMessage.show(failure.failureType);
      }
    }, (model) {
      errorStreamController.add(false);
      drinksListAsPerCategoryListStreamController.add(model);
    });
  }
}