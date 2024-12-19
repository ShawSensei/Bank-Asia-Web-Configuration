// import 'dart:convert'; // For base64 encoding
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../common/common.dart';
// // import '../../../data/data_sources/api/api/ComponentService.dart'; // Commented out, not needed now
// import '../../../domain/model/request_model/component_request.dart';
// import '../../../domain/model/request_model/page_info.dart';
//
//
// // Error Messages Constants
// const Map<String, String> errorMessages = {
//   'emptyUtilityName': 'Utility name cannot be empty.',
//   'emptyUtilityType': 'Utility type cannot be empty.',
//   'emptyImage': 'Image cannot be empty.',
// };
//
// class UtilityInputController extends GetxController {
//   // final ComponentService _componentService = ComponentService(); // Commented out, API Service not needed now
//
//   // Utility-specific controllers and observable variables
//   var selectedUtilityTypeValue = ''.obs;
//   var selectedImageValue = Rxn<Map<String, dynamic>>();
//   var selectedIconValue = ''.obs; // Base64 string for selected icon
//   var utilityNameTextFieldController = TextEditingController();
//   var labelTextFieldController = TextEditingController();
//
//   final List<String> utilityTypeItems = ['Electricity', 'Water', 'Gas'];
//   final Map<String, String> utilityCodes = {
//     'Electricity': 'ELC',
//     'Water': 'WTR',
//     'Gas': 'GAS',
//   };
//
//   final Map<String, IconData> utilityIcons = {
//     'Electricity': Icons.electric_bolt,
//     'Water': Icons.water_drop,
//     'Gas': Icons.fire_extinguisher,
//   };
//
//   final List<Map<String, dynamic>> iconItems = [
//     {'icon': Icons.electric_bolt, 'label': 'DESCO'},
//     {'icon': Icons.water_drop, 'label': 'WASA'},
//     {'icon': Icons.fire_extinguisher, 'label': 'GASA'},
//   ];
//
//   // List to store all saved utility data temporarily
//   final RxList<Map<String, dynamic>> savedUtilities = <Map<String, dynamic>>[].obs;
//
//   // Generate base64 icon string for the selected utility type
//   String _generateBase64Icon(String utilityType) {
//     final icon = utilityIcons[utilityType];
//     if (icon != null) {
//       // Convert the icon into base64 (simulate by encoding icon.toString())
//       return base64Encode(utf8.encode(icon.toString()));
//     }
//     return '';
//   }
//
//   // Save Utility Data
//   Future<void> saveUtilityData(BuildContext context , PageInfo pageInfo) async {
//     String? validationMessage = _validateUtilityInputs();
//
//     if (validationMessage != null) {
//       Common.showFlutterSnackbar(context, validationMessage, Colors.red);
//       return;
//     }
//
//     // Map the selected utility type to its code and base64 icon
//     String utilityCode = utilityCodes[selectedUtilityTypeValue.value] ?? '';
//     String base64Icon = _generateBase64Icon(selectedUtilityTypeValue.value);
//
//     // Create a temporary object for saved utility data
//     final utilityData = {
//       'utilityType': selectedUtilityTypeValue.value,
//       'utilityName': utilityNameTextFieldController.text,
//       'utilityIcon': base64Icon,
//       'label': labelTextFieldController.text,
//       'utilityCode': utilityCode,
//       'iconLabel': selectedImageValue.value?['label'],
//     };
//
//     // Add the data to the list of saved utilities
//     savedUtilities.add(utilityData);
//
//     // Clear inputs after saving
//     _clearUtilityInputs();
//
//     Common.showFlutterSnackbar(context, "Utility saved locally!", Colors.green);
//
//     // Commented out: Sending data to the API is not needed now
//     // try {
//     //   final response = await _componentService.saveComponent('utilityRoute', utilityRequest);
//
//     //   if (response['statusCode'] == 200 || response['statusCode'] == 201) {
//     //     _clearUtilityInputs();
//     //     Common.showFlutterSnackbar(context, "Utility saved successfully!", Colors.green);
//     //   } else {
//     //     Common.showFlutterSnackbar(context, "Error: ${response['message']}", Colors.amber.shade400);
//     //   }
//     // } catch (error) {
//     //   debugPrint("Error saving utility: $error");
//     //   Common.showFlutterSnackbar(context, "Error saving utility", Colors.amber.shade400);
//     // }
//   }
//
//   // Utility Input Validation
//   String? _validateUtilityInputs() {
//     if (selectedUtilityTypeValue.value.isEmpty) {
//       return errorMessages['emptyUtilityType'];
//     }
//     if (utilityNameTextFieldController.text.isEmpty) {
//       return errorMessages['emptyUtilityName'];
//     }
//     return null; // No validation errors
//   }
//
//   // Clear utility-specific inputs
//   void _clearUtilityInputs() {
//     selectedUtilityTypeValue.value = '';
//     selectedImageValue.value = null;
//     utilityNameTextFieldController.clear();
//     labelTextFieldController.clear();
//   }
// }
//
//


