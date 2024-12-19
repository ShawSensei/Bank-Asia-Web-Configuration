import 'package:dio/dio.dart';
import 'package:flutter_web/data/data_sources/dto/utilities_dto.dart';
import 'package:retrofit/retrofit.dart';



part 'utility_api.g.dart';


@RestApi()
abstract class UtilityApi {
  factory UtilityApi(Dio dio, {String baseUrl}) = _UtilityApi;

  @GET('bill-pay/v1/bill-pay/utilities')
  Future<UtilitiesDto> getUtilitiesInfo();

}


