import '../../../../core/failures/failures.dart';
import '../../../domain/usecases/categorylist/get_category_list_usecase.dart';
import '../../common_widgets/toast_message.dart';
import 'package:rxdart/rxdart.dart';

class FetchCategoriesBloc {
  GetCategoryListUseCase getCategoryListUseCase;

  FetchCategoriesBloc({required this.getCategoryListUseCase});

  ///error
  final errorStreamController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get errorStream => errorStreamController.stream;

  ///loader
  final loaderStreamController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loaderStream => loaderStreamController.stream;

  final categoryListStreamController = BehaviorSubject<List<String>>.seeded([]);

  Stream<List<String>> get categoryListStream =>
      categoryListStreamController.stream;

  showLoader({required bool value}) {
    loaderStreamController.add(value);
  }

  fetchCategories() async {
    errorStreamController.add(false);
    showLoader(value: true);
    var result = await getCategoryListUseCase.call();
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
      List<String> categories = [];
      if (model.drinks != null) {
        for (var element in model.drinks!) {
          categories.add(element.strCategory!);
        }
      }
      categoryListStreamController.add(categories);
    });
  }
}
