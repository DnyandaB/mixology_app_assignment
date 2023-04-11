import '../../../../core/failures/failures.dart';
import '../../../domain/usecases/drinkdetails/get_drink_details_as_per_id_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../common_widgets/toast_message.dart';

class DrinkDetailsBloc {
  GetDrinkDetailsAsPerIdUseCase getDrinkDetailsAsPerIdUseCase;

  DrinkDetailsBloc({required this.getDrinkDetailsAsPerIdUseCase});

  ///error
  final errorStreamController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get errorStream => errorStreamController.stream;

  ///loader
  final loaderStreamController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loaderStream => loaderStreamController.stream;

  final drinkImageController = BehaviorSubject<String>.seeded("");

  Stream<String> get drinkImageStream => drinkImageController.stream;

  final drinkIngredientsController = BehaviorSubject<List<String>>.seeded([]);

  Stream<List<String>> get drinkIngredientsStream =>
      drinkIngredientsController.stream;

  final drinkRecipeStepsController = BehaviorSubject<List<String>>.seeded([]);

  Stream<List<String>> get drinkRecipeStepsStream =>
      drinkRecipeStepsController.stream;

  showLoader({required bool value}) {
    loaderStreamController.add(value);
  }

  fetchDrinksDetailsAsPerId(String drinkId) async {
    errorStreamController.add(false);
    showLoader(value: true);
    var result = await getDrinkDetailsAsPerIdUseCase.call(drinkId);
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
      List<String> ingredients = [];
      errorStreamController.add(false);
      if (model.drinks != null) {
        for (var element in model.drinks!) {
          drinkImageController.add(element.strDrinkThumb ?? "");
          if (element.strIngredient1 != null) {
            ingredients.add(element.strIngredient1 ?? "");
          }
          if (element.strIngredient2 != null) {
            ingredients.add(element.strIngredient2 ?? "");
          }
          if (element.strIngredient3 != null) {
            ingredients.add(element.strIngredient3 ?? "");
          }
          if (element.strIngredient4 != null) {
            ingredients.add(element.strIngredient4 ?? "");
          }
          if (element.strIngredient5 != null) {
            ingredients.add(element.strIngredient5 ?? "");
          }
          if (element.strIngredient6 != null) {
            ingredients.add(element.strIngredient6 ?? "");
          }
          if (element.strIngredient7 != null) {
            ingredients.add(element.strIngredient7 ?? "");
          }
          if (element.strIngredient8 != null) {
            ingredients.add(element.strIngredient8 ?? "");
          }
          if (element.strIngredient9 != null) {
            ingredients.add(element.strIngredient9 ?? "");
          }
          if (element.strIngredient10 != null) {
            ingredients.add(element.strIngredient10 ?? "");
          }
          if (element.strIngredient11 != null) {
            ingredients.add(element.strIngredient11 ?? "");
          }
          if (element.strIngredient12 != null) {
            ingredients.add(element.strIngredient12 ?? "");
          }
          if (element.strIngredient13 != null) {
            ingredients.add(element.strIngredient13 ?? "");
          }
          if (element.strIngredient14 != null) {
            ingredients.add(element.strIngredient14 ?? "");
          }
          if (element.strIngredient15 != null) {
            ingredients.add(element.strIngredient15 ?? "");
          }
        }
      }
      drinkIngredientsController.add(ingredients);
    });
  }

  fetchDrinksRecipeStepsAsPerId(String drinkId) async {
    errorStreamController.add(false);
    showLoader(value: true);
    var result = await getDrinkDetailsAsPerIdUseCase.call(drinkId);
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
      List<String> drinkRecipeSteps = [];
      errorStreamController.add(false);
      if (model.drinks != null) {
        for (var element in model.drinks!) {
          drinkImageController.add(element.strDrinkThumb ?? "");
          if (element.strInstructions != null) {
            drinkRecipeSteps.add(element.strInstructions ?? "");
          }
          if (element.strInstructionsDE != null) {
            drinkRecipeSteps.add(element.strInstructionsDE ?? "");
          }
          if (element.strInstructionsFR != null) {
            drinkRecipeSteps.add(element.strInstructionsFR ?? "");
          }
          if (element.strInstructionsIT != null) {
            drinkRecipeSteps.add(element.strInstructionsIT ?? "");
          }
          if (element.strInstructionsZHHANS != null) {
            drinkRecipeSteps.add(element.strInstructionsZHHANS ?? "");
          }
          if (element.strInstructionsZHHANT != null) {
            drinkRecipeSteps.add(element.strInstructionsZHHANT ?? "");
          }
        }
      }
      drinkRecipeStepsController.add(drinkRecipeSteps);
    });
  }
}
