import 'package:get/get.dart';

import '../data/data_sources/dto/utilities_dto.dart';
import '../domain/model/response_model/utility_data_model.dart';




abstract class UtilityVariables extends GetxService {
  static var imei = '356480082668892'.obs;
  static var token = ''.obs;

  static var utilitiesList = <UtilityDto>[].obs;
  static var billerList = <Biller>[].obs;

}
