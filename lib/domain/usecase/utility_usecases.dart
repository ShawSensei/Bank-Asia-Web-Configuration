
import 'package:flutter_web/domain/usecase/reg_info_usecase.dart';
import 'package:flutter_web/domain/usecase/utilities_info_usecase.dart';

import 'dynamic_component_usecase.dart';

class UtilityUsecases {
  final UtilitiesInfoUsecase utilitiesInfoUsecase;
  final RegInfoUsecase regInfoUsecase;
  final DynamicComponentUsecase dynamicComponentUsecase;

  UtilityUsecases({
    required this.utilitiesInfoUsecase,
    required this.regInfoUsecase,
    required this.dynamicComponentUsecase,
});
}
