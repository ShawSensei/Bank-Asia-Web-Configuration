import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web/data/data_sources/dto/reg_info_dto.dart';
import 'package:flutter_web/domain/model/request_model/dynamic_component_req_model.dart';

import '../../domain/model/response_model/utility_data_model.dart';
import '../../domain/repository/utility_repository.dart';
import '../../main.dart';
import '../../util/exception_util.dart';
import '../../util/resource.dart';
import '../data_sources/api/api/utility_api.dart';
import '../data_sources/dto/utilities_dto.dart';

class UtilityRepositoryImpl implements UtilityRepository {
  final UtilityApi _utilityApi;

  UtilityRepositoryImpl(this._utilityApi);

  @override
  Stream<Resource<UtilitiesDto>> getUtilitiesInfo(Map<String, String> headers) async* {
    getIt<Dio>().options.headers = headers;
    debugPrint('getUtilitiesInfo reqBody: ');

    try {
      yield Resource.loading();
      final response = await _utilityApi.getUtilitiesInfo();
      debugPrint('getUtilitiesInfo response: $response');
      yield Resource.success(response);
    } on DioException catch (e) {
      debugPrint('getUtilitiesInfo error: $e');
      yield ExceptionUtil.handleDioException<UtilitiesDto>(e);
    }
  }

  @override
  Stream<Resource<RegInfoDto>> getRegInfo(Map<String, String> headers) async*{
    getIt<Dio>().options.headers = headers;
    debugPrint('getRegInfo reqBody: ');

    try {
      yield Resource.loading();
      final response = await _utilityApi.getRegInfo();
      debugPrint('getRegInfo response: ${response.toJson()}');
      yield Resource.success(response);
    } on DioException catch (e) {
      debugPrint('getRegInfo error: $e');
      yield ExceptionUtil.handleDioException<RegInfoDto>(e);
    }
  }

  @override
  Stream<Resource> sendDynamicComponentRequest(Map<String, String> headers, DynamicComponentReqModel reqBody) async*{
    getIt<Dio>().options.headers = headers;

    try {
      yield Resource.loading();
      final response = await _utilityApi.sendDynamicComponentRequest(reqBody);
      debugPrint('sendDynamicComponentRequest response: ${response.toJson()}');
      yield Resource.success(response.toSourceAcBalanceDataModel());
    } on DioException catch (e) {
      debugPrint('sendDynamicComponentRequest error: $e');
      yield ExceptionUtil.handleDioException<DynamicComponentReqModel>(e);
    }

  }

  // @override
  // Stream<Resource<UtilityDataModel>> getUtilitiesInfo(Map<String, String> headers) async* {
  //   final dio = getIt<Dio>();
  //   dio.options.headers = headers;
  //
  //   try {
  //     yield Resource.loading();
  //
  //     final response = await _utilityApi.getUtilitiesInfo();
  //     //final utilitiesJson = response.utilities?.map((utility) => utility.toJson()).toList();
  //     debugPrint('Utilities response: ${response.toJson()}');
  //
  //     yield Resource.success(response.toUtilityDataModel());
  //   } on DioException catch (e) {
  //     debugPrint('Utilities error: $e');
  //     yield ExceptionUtil.handleDioException<UtilityDataModel>(e);
  //   }
  // }
}
