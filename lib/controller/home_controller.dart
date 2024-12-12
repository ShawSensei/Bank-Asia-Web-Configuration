import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/ComponentService.dart';
import '../common/common.dart';
import '../model/request_model/component_request.dart';
import '../model/request_model/page_info.dart';

// Error Messages Constants
const Map<String, String> errorMessages = {
  'emptyType': 'Please select a type.',
  'emptyLabel': 'Label cannot be empty.',
  'emptyPlaceholder': 'Placeholder cannot be empty.',
  'emptyIsRequired': 'IsRequired cannot be empty.',
  'emptyItems': 'Items cannot be empty.',
  'emptySelectedItem': 'Selected dropdown value cannot be empty.',
  'emptyUrlMethod': 'API URL or Method cannot be empty.',
  'emptyNavigation': 'Navigation page name cannot be empty.',
  'emptyUtilityName': 'Utility name cannot be empty.',
  'emptyUtilityType': 'Utility type cannot be empty.',
  'emptyIcon': 'Icon cannot be empty.',
};

// Updated HomeController
class HomeController extends GetxController {
  final ComponentService _componentService = ComponentService(); // API Service

  // TextField Controllers
  var labelTextFieldController = TextEditingController();
  var valueTextFieldController = TextEditingController();
  var placeholderTextFieldController = TextEditingController();
  var urlTextFieldController = TextEditingController();
  var itemsTextFieldController = TextEditingController();
  var selectedItemTextFieldController = TextEditingController();
  var validationFieldController = TextEditingController();
  var utilityNameTextFieldController = TextEditingController();

  // Observable dropdown values
  var selectedDropdownValue = ''.obs;
  var selectedIsRequiredValue = ''.obs;
  var selectedActionTypeValue = ''.obs;
  var selectedMethodValue = ''.obs;
  var selectedImageValue = Rxn<Map<String, dynamic>>();
  var selectedUtilityTypeValue = ''.obs;

  var selectedUtilityDropdownValue = Rx<Map<String, dynamic>?>(null);
  var utilityDropdownItems = <Map<String, dynamic>>[].obs;

  // Dropdown options
  final RxList<String> dropdownItems = [
    'Text', 'InputField', 'Button', 'Radio Button', 'Dropdown', 'Checkbox', 'Utility'
  ].obs;

  final List<String> isRequiredItems = ['Yes', 'No'];
  final List<String> actionTypeItems = ['Navigation', 'API Call'];
  final List<String> methodItems = ['GET', 'POST'];
  final List<Map<String, dynamic>> iconItems = [
    {'icon': Icons.electric_bolt, 'label': 'DESCO'},
    {'icon': Icons.water_drop, 'label': 'WASA'},
    {'icon': Icons.fire_extinguisher, 'label': 'GASA'},
  ];
  final List<String> utilityTypeItems = ['Electricity', 'Water', 'Gas'];

  @override
  void onInit() {
    super.onInit();
    _fetchUtilityDropdownItems();
  }

  // Fetch utility dropdown items dynamically
  Future<void> _fetchUtilityDropdownItems() async {
    try {
      // Simulating API response with dummy data for now
      await Future.delayed(const Duration(seconds: 1)); // Simulating network delay
      List<Map<String, dynamic>> response = [
        {'image': Icons.home, 'title': 'DESCO', 'type': 'Electricity'},
        {'image': Icons.water_drop, 'title': 'WASA', 'type': 'Water'},
        {'image': Icons.gas_meter, 'title': 'GASA', 'type': 'Gas'},
      ];

      utilityDropdownItems.assignAll(response);
    } catch (e) {
      debugPrint('Error fetching utility dropdown items: $e');
    }
  }

  // Validate and save data
  Future<void> saveData(BuildContext context, PageInfo info) async {
    String? validationMessage = _validateInputs();

    if (validationMessage != null) {
      Common.showFlutterSnackbar(context, validationMessage, Colors.red);
      return;
    }

    // Prepare request model
    final requestData = _createRequestModel();

    try {
      // Sending data to the API and getting the response
      final response = await _componentService.saveComponent(info.pageRoute ?? '', requestData);

      // Handle the response
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        _clearInputs(); // Clear fields after successful save
        Common.showFlutterSnackbar(context, "Data saved successfully!", Colors.green);
      } else {
        Common.showFlutterSnackbar(context, "Error: ${response['message']}", Colors.amber.shade400);
      }
    } catch (error) {
      debugPrint("Error saving data: $error");
      Common.showFlutterSnackbar(context, "Error saving data", Colors.amber.shade400);
    }
  }

  // Validation logic
  String? _validateInputs() {
    // Ensure utility dropdown is selected
    if (selectedUtilityDropdownValue.value == null) {
      return "Please select a utility.";
    }

    if (selectedDropdownValue.value.isEmpty) {
      return errorMessages['emptyType'];
    }
    if (labelTextFieldController.text.isEmpty) {
      return errorMessages['emptyLabel'];
    }

    // Validation for specific types
    if (['InputField', 'Dropdown', 'Button'].contains(selectedDropdownValue.value) &&
        selectedIsRequiredValue.value.isEmpty) {
      return errorMessages['emptyIsRequired'];
    }

    if (['InputField', 'Dropdown'].contains(selectedDropdownValue.value) &&
        validationFieldController.text.isEmpty) {
      return "Validation error message cannot be empty.";
    }

    if (['Dropdown', 'Radio Button'].contains(selectedDropdownValue.value) &&
        itemsTextFieldController.text.isEmpty) {
      return errorMessages['emptyItems'];
    }

    if (selectedDropdownValue.value == 'Dropdown' &&
        selectedItemTextFieldController.text.isEmpty) {
      return errorMessages['emptySelectedItem'];
    }

    if (selectedDropdownValue.value == 'Button') {
      if (selectedActionTypeValue.value == "API Call" &&
          (urlTextFieldController.text.isEmpty || selectedMethodValue.value.isEmpty)) {
        return errorMessages['emptyUrlMethod'];
      }
      if (selectedActionTypeValue.value == "Navigation" &&
          urlTextFieldController.text.isEmpty) {
        return errorMessages['emptyNavigation'];
      }
    }

    return null; // No validation errors
  }

  // Build ComponentRequest model
  ComponentRequest _createRequestModel() {
    final selectedUtility = selectedUtilityDropdownValue.value;

    return ComponentRequest(
      type: selectedDropdownValue.value,
      label: labelTextFieldController.text,
      image: selectedUtility != null
          ? {'image': selectedUtility['image'].toString(), 'label': selectedUtility['title']}
          : null,
      utilityName: selectedUtility?['title'],
      utilityType: selectedUtility?['type'],
      utilityIcon: selectedUtility?['image'].toString(),
      utilityCode: selectedUtility?['code'],
      value: selectedDropdownValue.value == 'InputField' ? valueTextFieldController.text : null,
      placeholder: selectedDropdownValue.value == 'InputField'
          ? placeholderTextFieldController.text
          : null,
      required: ['InputField', 'Dropdown', 'Button'].contains(selectedDropdownValue.value)
          ? selectedIsRequiredValue.value
          : null,
      validationMsg: ['InputField', 'Dropdown'].contains(selectedDropdownValue.value)
          ? validationFieldController.text
          : null,
      items: ['Dropdown', 'Radio Button'].contains(selectedDropdownValue.value)
          ? itemsTextFieldController.text
          : null,
      selectedItem: selectedDropdownValue.value == 'Dropdown'
          ? selectedItemTextFieldController.text
          : null,
      actionType: selectedDropdownValue.value == 'Button'
          ? selectedActionTypeValue.value
          : null,
      url: selectedDropdownValue.value == 'Button'
          ? urlTextFieldController.text
          : null,
      method: selectedDropdownValue.value == 'Button'
          ? selectedMethodValue.value
          : null,
    );
  }

  // Clear input fields
  void _clearInputs() {
    labelTextFieldController.clear();
    valueTextFieldController.clear();
    placeholderTextFieldController.clear();
    selectedIsRequiredValue.value = '';
    validationFieldController.clear();
    itemsTextFieldController.clear();
    selectedItemTextFieldController.clear();
    urlTextFieldController.clear();
    selectedMethodValue.value = '';
    selectedDropdownValue.value = '';
    selectedUtilityDropdownValue.value = null; // Reset utility dropdown
  }
}
