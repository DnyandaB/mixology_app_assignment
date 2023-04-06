import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';

import '../core/network_info/network_info.dart';
import '../core/networks/networks_helper.dart';
import '../core/networks/response_parser.dart';
import '../feature/data/remotedatasource/get_categories_from_api.dart';
import '../feature/data/repositories/get_categories_repo_impl.dart';
import '../feature/domain/repositories/get_categories_repository.dart';
import '../feature/domain/usecases/categories/get_category_list_usecase.dart';
import '../feature/presentation/dashboard/bloc/categories_listing_bloc.dart';

GetIt si = GetIt.instance;

Future<void> init() async {
  si.registerFactory<FetchCategoriesBloc>(
      () => FetchCategoriesBloc(getCategoryListUsecase: si()));

  ///UseCases
  si.registerLazySingleton<GetCategoryListUsecase>(
      () => GetCategoryListUsecase(getCategoryRepository: si()));

  ///Repository
  si.registerLazySingleton<GetCategoryRepository>(
      () => GetCategoryRepositoryImpl(getCategoriesDatasource: si()));

  ///Remote DataSource
  si.registerLazySingleton<GetCategoriesDatasource>(
      () => GetCategoriesDatasourceImpl(responseParser: si()));

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
