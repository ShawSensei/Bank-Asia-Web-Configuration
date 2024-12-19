import 'package:flutter_web/data/data_sources/dto/utilities_dto.dart';

import '../../util/resource.dart';
import '../model/response_model/utility_data_model.dart';
import '../repository/utility_repository.dart';

class UtilitiesInfoUsecase {
  final UtilityRepository _utilityRepository;

  UtilitiesInfoUsecase(this._utilityRepository);

  // Stream<Resource<UtilityDataModel>> call(Map<String, String> headers,
  //     ) async* {
  Stream<Resource<UtilitiesDto>> call(Map<String, String> headers,
      ) async* {
    yield* _utilityRepository.getUtilitiesInfo(headers);
  }
}