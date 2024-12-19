import 'package:flutter_web/data/data_sources/dto/utilities_dto.dart';

import '../../util/resource.dart';
import '../model/response_model/utility_data_model.dart';


abstract class UtilityRepository {
  Stream<Resource<UtilitiesDto>> getUtilitiesInfo(Map<String, String> headers,);
}