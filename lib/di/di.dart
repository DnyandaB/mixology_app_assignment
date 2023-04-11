import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:login_demo/feature/data/remotedatasource/get_drinks_list_by_category.dart';
import 'package:login_demo/feature/data/repositories/get_drinks_list_by_category_repo_impl.dart';
import 'package:login_demo/feature/domain/repositories/get_drinks_by_category_repository.dart';
import 'package:login_demo/feature/domain/usecases/drinkslist/get_drinks_list_as_per_category_usecase.dart';

import '../core/network_info/network_info.dart';
import '../core/networks/networks_helper.dart';
import '../core/networks/response_parser.dart';
import '../feature/data/remotedatasource/get_categories_from_api.dart';
import '../feature/data/repositories/get_categories_repo_impl.dart';
import '../feature/domain/repositories/get_categories_repository.dart';
import '../feature/domain/usecases/categorylist/get_category_list_usecase.dart';
import '../feature/presentation/dashboard/bloc/categories_listing_bloc.dart';
import '../feature/presentation/drinks_listing_as_per_category/bloc/drinks_listing_bloc.dart';

GetIt si = GetIt.instance;

Future<void> init() async {
  ///Bloc
  si.registerFactory<FetchCategoriesBloc>(
      () => FetchCategoriesBloc(getCategoryListUseCase: si()));
  si.registerFactory<FetchDrinksListingBloc>(
      () => FetchDrinksListingBloc(getDrinksListAsPerCategoryUseCase: si()));

  ///UseCases
  si.registerLazySingleton<GetCategoryListUseCase>(
      () => GetCategoryListUseCase(getCategoryRepository: si()));
  si.registerLazySingleton<GetDrinksListAsPerCategoryUseCase>(() =>
      GetDrinksListAsPerCategoryUseCase(
          getDrinksListByCategoryRepository: si()));

  ///Repository
  si.registerLazySingleton<GetCategoryRepository>(
      () => GetCategoryRepositoryImpl(getCategoriesDatasource: si()));
  si.registerLazySingleton<GetDrinksListByCategoryRepository>(() =>
      GetDrinksListByCategoryRepositoryImpl(
          getDrinksListByCategoryDataSource: si()));

  ///Remote DataSource
  si.registerLazySingleton<GetCategoriesDatasource>(
      () => GetCategoriesDatasourceImpl(responseParser: si()));
  si.registerLazySingleton<GetDrinksListByCategoryDataSource>(() =>
      GetDrinksListByCategoryDataSourceImpl(responseParser: si()));

  ///Network Info
  si.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: si(), dataConnectionChecker: si()));
  si.registerLazySingleton<Connectivity>(() => Connectivity());
  si.registerLazySingleton<InternetConnectionChecker>(
          () => InternetConnectionChecker());

  ///Network Helper
  si.registerLazySingleton<NetworkHelper>(
      () => NetworkHelper(networkInfo: si(), dio: si()));
  si.registerLazySingleton<ResponseParser>(() => ResponseParser(helper: si()));
  si.registerLazySingleton<Dio>(() => Dio());
}
