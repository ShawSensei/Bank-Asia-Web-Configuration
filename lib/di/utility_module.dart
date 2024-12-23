import 'package:dio/dio.dart';
import 'package:flutter_web/domain/repository/utility_repository.dart';

import '../../../main.dart';
import '../common/core_urls.dart';
import '../data/data_sources/api/api/utility_api.dart';
import '../data/repositoryImpl/utility_repository_impl.dart';
import '../domain/usecase/dynamic_component_usecase.dart';
import '../domain/usecase/reg_info_usecase.dart';
import '../domain/usecase/utilities_info_usecase.dart';
import '../domain/usecase/utility_usecases.dart';


abstract class UtilityModule {
  static void dependencies() {

    // Register Dio
    getIt.registerLazySingleton<Dio>(
          () => Dio(),
    );

    getIt.registerLazySingleton<UtilityApi>(
      () => UtilityApi(getIt<Dio>(), baseUrl: CoreUrls.baseUrl),
    );

    getIt.registerLazySingleton<UtilityRepository>(
      () => UtilityRepositoryImpl(getIt<UtilityApi>()),
    );

    getIt.registerLazySingleton<UtilityUsecases>(
      () => UtilityUsecases(utilitiesInfoUsecase: UtilitiesInfoUsecase(getIt<UtilityRepository>()),
        regInfoUsecase: RegInfoUsecase(getIt<UtilityRepository>()),
        dynamicComponentUsecase: DynamicComponentUsecase(getIt<UtilityRepository>()),

      ),
    );
  }
}
