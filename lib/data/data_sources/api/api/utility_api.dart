import 'package:dio/dio.dart';
import 'package:flutter_web/data/data_sources/dto/reg_info_dto.dart';
import 'package:flutter_web/data/data_sources/dto/utilities_dto.dart';
import 'package:flutter_web/domain/model/request_model/dynamic_component_req_model.dart';
import 'package:retrofit/retrofit.dart';



part 'utility_api.g.dart';


@RestApi()
abstract class UtilityApi {
  factory UtilityApi(Dio dio, {String baseUrl}) = _UtilityApi;

  @GET('bill-pay/v1/bill-pay/utilities')
  Future<UtilitiesDto> getUtilitiesInfo();

  @GET('dynamic-ui/v1/api/registration-info')
  Future<RegInfoDto> getRegInfo();


  @POST('dynamic-ui/v1/api/check-request')
  Future<dynamic> sendDynamicComponentRequest(
      @Body() DynamicComponentReqModel reqBody,
      );
}


