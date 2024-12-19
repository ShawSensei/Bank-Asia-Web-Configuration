import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../../common/header_data.dart';
import '../../../data/data_sources/dto/utilities_dto.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../../domain/model/response_model/utility_data_model.dart';
import '../../../domain/usecase/utility_usecases.dart';
import '../../../main.dart';
import '../../../util/resource.dart';
import '../../../util/utility_variables.dart';
import '../../custom_view/custom_dialog.dart';

class UtilityListController extends GetxController {
  final _utilityUsecase = getIt<UtilityUsecases>();

  final _isLoading = false.obs;
  RxInt selectedUtilityIndex = RxInt(-1);

  // Make utilitiesList and billerList observable
  var utilitiesList = <Utility>[].obs; // Observable list of utilities
  var billerList = <Biller>[].obs; // Observable list of billers

  // Create a list to manage the color for each utility item
  var utilityItemColors = <Rx<Color>>[].obs;

  final PageInfo pageInfo;

  void loading(bool value) {
    if (value && !_isLoading.value) {
      CustomDialog.showLoadingDialog();
    } else if (!value && _isLoading.value) {
      Get.back();
    }
    _isLoading.value = value;
  }

  UtilityListController(this.pageInfo);

  @override
  void onInit() {
    super.onInit();
    utilityItemColors.assignAll(List.generate(utilitiesList.length, (_) => Rx<Color>(Colors.white)));
  }

  // Fetch Utility List
  Future<void> getUtilitiesInfo() async {
    _utilityUsecase.utilitiesInfoUsecase(HeaderData.headerPublic).listen((resource) {
      switch (resource.status) {
        case Status.loading:
          loading(true);
          break;
        case Status.success:
          loading(false);

          // Cast utilities list to proper type (Utility)
          utilitiesList.assignAll(
            (resource.data!.utilities ?? []).map((utilityDto) => utilityDto.toUtility()).toList(),
          );

          // Map BillerDto to Biller and filter out nulls
          var allBillers = utilitiesList
              .expand((utility) => utility.billers ?? []) // Flatten all biller lists
              .cast<BillerDto>() // Ensure it's explicitly cast to BillerDto
              .map((billerDto) => billerDto.toBiller()) // Convert each BillerDto to Biller
              .where((biller) => biller != null) // Filter out null billers (if any)
              .toList(); // Convert to List<Biller>

          // Assign to observable billerList
          billerList.assignAll(allBillers);

          // Initialize utilityItemColors after data is loaded
          utilityItemColors.assignAll(List.generate(utilitiesList.length, (_) => Rx<Color>(Colors.white)));
          break;
        case Status.error:
          loading(false);
          CustomDialog.showError('${resource.errorMessage}');
          break;
      }
    });
  }



  void filterBillers(String utilityCode, int index) {
    debugPrint("index $index");
    debugPrint("selectedUtilityIndex.value ${selectedUtilityIndex.value}");

    // Change the color of the tapped item
    if (index == selectedUtilityIndex.value) {
      utilityItemColors[index].value = Colors.blue.shade100;
    } else {
      utilityItemColors[index].value = Colors.white;
    }

    // Filter the billers based on the selected utility code
    billerList.value = UtilityVariables.billerList
        .where((biller) => biller.utilityCode == utilityCode)
        .toList();
  }

  // Add a utility to the list
  void addUtility(Utility utility) {
    utilitiesList.add(utility);  // This will automatically update the UI
    update();  // Trigger the UI update
  }

  // Delete utility method
  void deleteUtility(int index) {
    utilitiesList.removeAt(index);
    update();  // Trigger the UI update after deletion
  }

  IconData decodeBase64ToIconData(String base64Icon) {
    try {
      // Decode the base64 string to bytes
      final bytes = base64Decode(base64Icon);

      // Convert the bytes back to the integer value (big-endian)
      final int value = ByteData.sublistView(Uint8List.fromList(bytes)).getInt32(0, Endian.big);

      // Ensure the value is within the valid range for IconData
      if (value >= 0 && value <= 0x10FFFF) {
        return IconData(value, fontFamily: 'MaterialIcons');
      } else {
        throw const FormatException("Invalid IconData value");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding base64 icon: $e');
      }
      return Icons.help; // Return a default icon in case of failure
    }
  }

}
