import 'package:flutter_web/data/data_sources/dto/reg_info_dto.dart';
import 'package:flutter_web/data/data_sources/dto/utilities_dto.dart';

import '../../util/resource.dart';
import '../model/response_model/utility_data_model.dart';
import '../repository/utility_repository.dart';

class RegInfoUsecase {
  final UtilityRepository _utilityRepository;

  RegInfoUsecase(this._utilityRepository);

  // Stream<Resource<UtilityDataModel>> call(Map<String, String> headers,
  //     ) async* {
  Stream<Resource<RegInfoDto>> call(Map<String, String> headers,
      ) async* {
    yield* _utilityRepository.getRegInfo(headers);
  }
}