import 'dart:convert'; // For base64 encoding
import 'package:flutter/material.dart';
import 'package:flutter_web/presentation/controller/controller/utility_list_controller.dart';
import 'package:get/get.dart';
import 'dart:typed_data';

import '../../../common/common.dart';
import '../../../data/data_sources/dto/utilities_dto.dart';
import '../../../domain/model/response_model/utility_data_model.dart';
import '../../../util/utility_variables.dart'; // For shared utility variables
import '../../../domain/model/request_model/page_info.dart';

// Error Messages Constants
const Map<String, String> errorMessages = {
  'emptyUtilityName': 'Utility name cannot be empty.',
  'emptyUtilityType': 'Utility type cannot be empty.',
  'emptyImage': 'Image cannot be empty.',
};

class UtilityInputController extends GetxController {
  final UtilityListController _listController = Get.find<UtilityListController>();


  // Utility-specific controllers and observable variables
  var selectedUtilityTypeValue = ''.obs;
  var selectedImageValue = Rxn<Map<String, dynamic>>();
  var selectedIconValue = ''.obs; // Base64 string for selected icon
  var utilityNameTextFieldController = TextEditingController();
  var labelTextFieldController = TextEditingController();

  final List<String> utilityTypeItems = ['Electricity', 'Water', 'Gas'];
  final Map<String, String> utilityCodes = {
    'Electricity': 'ELC',
    'Water': 'WTR',
    'Gas': 'GAS',
  };

  final Map<String, IconData> utilityIcons = {
    'Electricity': Icons.electric_bolt,
    'Water': Icons.water_drop,
    'Gas': Icons.fire_extinguisher,
  };

  final List<Map<String, dynamic>> iconItems = [
    {'icon': Icons.electric_bolt, 'label': 'DESCO'},
    {'icon': Icons.water_drop, 'label': 'WASA'},
    {'icon': Icons.fire_extinguisher, 'label': 'GASA'},
  ];

  String _generateBase64Icon(String utilityType) {
    final icon = utilityIcons[utilityType];
    if (icon != null) {
      // Convert the icon into base64 by encoding the integer value (icon.codePoint)
      final int iconValue = icon.codePoint; // Get the integer value of the icon
      final bytes = ByteData(4)..setInt32(0, iconValue, Endian.big); // Store the value in 4 bytes
      return base64Encode(bytes.buffer.asUint8List()); // Convert to base64
    }
    return '';
  }


// Save utility data
  Future<void> saveUtilityData(BuildContext context, PageInfo pageInfo) async {
    String? validationMessage = _validateUtilityInputs();

    if (validationMessage != null) {
      Common.showFlutterSnackbar(context, validationMessage, Colors.red);
      return;
    }

    String utilityCode = utilityCodes[selectedUtilityTypeValue.value] ?? '';
    String base64Icon = _generateBase64Icon(selectedUtilityTypeValue.value);

    final utility = Utility(
      utilityCode: utilityCode,
      utilityName: utilityNameTextFieldController.text,
      utilityIcon: base64Icon,
      billers: [],
    );

    final utilityData = UtilityDto(
      utilityCode: utilityCode,
      utilityName: utility.utilityName,
      utilityIcon: utility.utilityIcon,
      billers: [],
    );

    UtilityVariables.utilitiesList.add(utilityData);

    // Add to the list in UtilityListController
    _listController.addUtility(utility);

    _clearUtilityInputs();
    Common.showFlutterSnackbar(context, "Utility saved locally!", Colors.green);
  }



  // Utility Input Validation
  String? _validateUtilityInputs() {
    if (selectedUtilityTypeValue.value.isEmpty) {
      return errorMessages['emptyUtilityType'];
    }
    if (utilityNameTextFieldController.text.isEmpty) {
      return errorMessages['emptyUtilityName'];
    }
    return null; // No validation errors
  }

  // Clear utility-specific inputs
  void _clearUtilityInputs() {
    selectedUtilityTypeValue.value = '';  // Reset utility type
    selectedImageValue.value = null;  // Reset selected image/icon
    selectedIconValue.value = '';  // Reset selected icon value (if any)

    utilityNameTextFieldController.clear();  // Clear the utility name text field
    labelTextFieldController.clear();  // Clear the label text field
  }
}
