

import 'package:flutter_web/domain/model/request_model/dynamic_component_req_model.dart';

import '../../util/resource.dart';
import '../repository/utility_repository.dart';

class DynamicComponentUsecase {
  final UtilityRepository _utilityRepository;

  DynamicComponentUsecase(this._utilityRepository);

  // Stream<Resource<UtilityDataModel>> call(Map<String, String> headers,
  //     ) async* {
  Stream<Resource<dynamic>> call(Map<String, String> headers, DynamicComponentReqModel reqBody) async* {
    yield* _utilityRepository.sendDynamicComponentRequest(headers, reqBody);
  }
}