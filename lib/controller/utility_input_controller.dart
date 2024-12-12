import 'dart:convert'; // For base64 encoding
import 'package:flutter/material.dart';
import 'package:flutter_web/model/request_model/page_info.dart';
import 'package:get/get.dart';
import '../api/ComponentService.dart';
import '../common/common.dart';
import '../model/request_model/component_request.dart';

// Error Messages Constants
const Map<String, String> errorMessages = {
  'emptyUtilityName': 'Utility name cannot be empty.',
  'emptyUtilityType': 'Utility type cannot be empty.',
  'emptyImage': 'Image cannot be empty.',
};

class UtilityInputController extends GetxController {
  final ComponentService _componentService = ComponentService(); // API Service

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


  // Generate base64 icon string for the selected utility type
  String _generateBase64Icon(String utilityType) {
    final icon = utilityIcons[utilityType];
    if (icon != null) {
      // Convert the icon into base64 (simulate by encoding icon.toString())
      return base64Encode(utf8.encode(icon.toString()));
    }
    return '';
  }

  // Save Utility Data
  Future<void> saveUtilityData(BuildContext context, PageInfo pageInfo) async {
    String? validationMessage = _validateUtilityInputs();

    if (validationMessage != null) {
      Common.showFlutterSnackbar(context, validationMessage, Colors.red);
      return;
    }

    // Map the selected utility type to its code and base64 icon
    String utilityCode = utilityCodes[selectedUtilityTypeValue.value] ?? '';
    String base64Icon = _generateBase64Icon(selectedUtilityTypeValue.value);

    // Prepare request model for utility data
    final utilityRequest = ComponentRequest(
      type: 'Utility',
      utilityType: selectedUtilityTypeValue.value,
      utilityName: utilityNameTextFieldController.text,
      utilityIcon: base64Icon,
      label: labelTextFieldController.text,
      utilityCode: utilityCode,
    );

    try {
      // Send data to API
      final response = await _componentService.saveComponent('utilityRoute', utilityRequest);

      // Handle response
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        _clearUtilityInputs();
        Common.showFlutterSnackbar(context, "Utility saved successfully!", Colors.green);
      } else {
        Common.showFlutterSnackbar(context, "Error: ${response['message']}", Colors.amber.shade400);
      }
    } catch (error) {
      debugPrint("Error saving utility: $error");
      Common.showFlutterSnackbar(context, "Error saving utility", Colors.amber.shade400);
    }
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
    selectedUtilityTypeValue.value = '';
    selectedIconValue.value = '';
    utilityNameTextFieldController.clear();
  }
}
