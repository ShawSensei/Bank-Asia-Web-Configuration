import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web/domain/model/request_model/dynamic_single_page_req_model.dart';
import 'package:get/get.dart';
import '../../../common/common.dart';
import '../../../data/data_sources/api/api/ComponentService.dart';
import '../../../domain/model/request_model/component_request.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../../util/utility_variables.dart';


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
  'emptyIcon': 'Icon cannot be empty.',
};

// Updated HomeController
class DynamicSinglePageController extends GetxController {
  // TextField Controllers
  var labelTextFieldController = TextEditingController();
  var valueTextFieldController = TextEditingController();
  var placeholderTextFieldController = TextEditingController();
  var urlTextFieldController = TextEditingController();
  var itemsTextFieldController = TextEditingController();
  var selectedItemTextFieldController = TextEditingController();
  var validationFieldController = TextEditingController();

  var apiUrlTextFieldController = TextEditingController();
  var requestBodyTextFieldController = TextEditingController();
  var headerBodyTextFieldController = TextEditingController();

  var thirdPartyApiUrlTextFieldController = TextEditingController();
  var thirdPartyRequestBodyTextFieldController = TextEditingController();
  var thirdPartyHeaderBodyTextFieldController = TextEditingController();

  // Observable dropdown values
  var selectedDropdownValue = ''.obs;
  var selectedIsRequiredValue = ''.obs;
  var selectedActionTypeValue = ''.obs;

  var selectedMethodValue = ''.obs;
  var selectedApiValue = ''.obs;
  var selectedHeaderOptionValue = ''.obs;

  var selectedThirdPartyMethodValue = ''.obs;
  var selectedThirdPartyApiValue = ''.obs;
  var selectedThirdPartyHeaderOptionValue = ''.obs;

  // Dropdown options
  final RxList<String> dropdownItems = [
    'Text', 'InputField', 'Button', 'Radio Button', 'Dropdown', 'Checkbox'
  ].obs;

  final List<String> isRequiredItems = ['Yes', 'No'];
  final List<String> isInitialApi = ['Yes', 'No'];
  final List<String> actionTypeItems = ['Navigation', 'API Call'];
  final List<String> methodItems = ['GET', 'POST', 'PUT', 'DELETE'];
  final List<String> headerOptionItems = ['None', 'Public', 'Private'];

  @override
  void onInit() {
    super.onInit();
  }

  var componentsList = <DynamicSinglePageReqModel>[].obs;

  // Save data
  void saveData(BuildContext context) {
    // Validate inputs
    String? validationMessage = _validateInputs();
    if (validationMessage != null) {
      Common.showFlutterSnackbar(context, validationMessage, Colors.red);
      return;
    }

    // Build request body for the current component
    final newComponent = _buildRequestBody();

    // Add the component to the local observable list
    componentsList.add(newComponent);

    // Add the component to the global shared list in UtilityVariables
    UtilityVariables.componentsVariableList.add(newComponent);

    // Clear inputs for new component creation
    _clearInputs();

    // Notify user
    Common.showFlutterSnackbar(context, "Component saved successfully!", Colors.green);
  }

  // Validation logic
  String? _validateInputs() {
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

  // Create the request body model for dynamic single page data
  DynamicSinglePageReqModel _buildRequestBody() {
    return DynamicSinglePageReqModel(
      type: selectedDropdownValue.value,
      label: labelTextFieldController.text,
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
      url: selectedDropdownValue.value == 'Button' && urlTextFieldController.text.isNotEmpty
          ? urlTextFieldController.text
          : null,
      method: selectedDropdownValue.value == 'Button' && selectedMethodValue.value.isNotEmpty
          ? selectedMethodValue.value
          : null,
      apiUrl: apiUrlTextFieldController.text.isNotEmpty ? apiUrlTextFieldController.text : null,
      requestBody: requestBodyTextFieldController.text.isNotEmpty
          ? requestBodyTextFieldController.text
          : null,
      headerBody: headerBodyTextFieldController.text.isNotEmpty
          ? headerBodyTextFieldController.text
          : null,
      selectedHeaderOption: selectedHeaderOptionValue.value.isNotEmpty
          ? selectedHeaderOptionValue.value
          : null,

      // New third-party API fields
      thirdPartyApiUrl: thirdPartyApiUrlTextFieldController.text.isNotEmpty
          ? thirdPartyApiUrlTextFieldController.text
          : null,
      thirdPartyRequestBody: thirdPartyRequestBodyTextFieldController.text.isNotEmpty
          ? thirdPartyRequestBodyTextFieldController.text
          : null,
      thirdPartyHeaderBody: thirdPartyHeaderBodyTextFieldController.text.isNotEmpty
          ? thirdPartyHeaderBodyTextFieldController.text
          : null,
      selectedThirdPartyMethod: selectedThirdPartyMethodValue.value.isNotEmpty
          ? selectedThirdPartyMethodValue.value
          : null,
      selectedThirdPartyHeaderOption: selectedThirdPartyHeaderOptionValue.value.isNotEmpty
          ? selectedThirdPartyHeaderOptionValue.value
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

    // Clear third-party API fields
    thirdPartyApiUrlTextFieldController.clear();
    thirdPartyRequestBodyTextFieldController.clear();
    thirdPartyHeaderBodyTextFieldController.clear();
    selectedThirdPartyMethodValue.value = '';
    selectedThirdPartyApiValue.value = '';
    selectedThirdPartyHeaderOptionValue.value = '';
  }
}

