import 'package:flutter_web/data/data_sources/dto/reg_info_dto.dart';
import 'package:flutter_web/data/data_sources/dto/utilities_dto.dart';
import 'package:flutter_web/domain/model/request_model/dynamic_component_req_model.dart';

import '../../util/resource.dart';


abstract class UtilityRepository {
  Stream<Resource<UtilitiesDto>> getUtilitiesInfo(Map<String, String> headers,);

  Stream<Resource<RegInfoDto>> getRegInfo(Map<String, String> headers,);

  Stream<Resource<dynamic>> sendDynamicComponentRequest(Map<String, String> headers, DynamicComponentReqModel reqBody);

}