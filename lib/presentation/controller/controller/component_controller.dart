import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common.dart';
import '../../../data/data_sources/api/api/ComponentService.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../../domain/model/request_model/utility_req_model.dart';
import '../../../domain/model/response_model/component_response.dart';



class ComponentController extends GetxController {
  final String baseUrl = "https://api.example.com"; // Replace with your API URL
  var components = <ComponentResponse>[].obs;

  final PageInfo pageInfo;
  final ComponentService _componentService;

  ComponentController(this.pageInfo, this._componentService);

  // Fetch Utility Data
  Future<void> fetchUtilityData(BuildContext context) async {
    try {
      // Prepare request model
      final requestBody = UtilityReqModel(
        categoryCode: "ELC", // Replace with dynamic category code if necessary
        subcategoryCode: "ELC001", // Placeholder for now
      );

      // Send request to API
      final utilities = await _componentService.fetchComponents(
        'http://10.11.201.137:8085/bill-pay/v1/bill-pay/utilities/electricity',
        requestBody,
      );

      // Handle response
      components.value = utilities;  // Set the fetched utilities to the observable list
      Common.showFlutterSnackbar(context, "Utilities fetched successfully!", Colors.green);
    } catch (error) {
      debugPrint("Error fetching utilities: $error");
      Common.showFlutterSnackbar(context, "Error fetching utilities", Colors.red);
    }
  }

  // Delete Component
  Future<void> deleteComponent(String id, PageInfo info, BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/components/${info.pageRoute}/$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        fetchUtilityData(context); // Pass context here for showing snackbar
      } else {
        debugPrint("Error deleting component: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error deleting component: $error");
    }
  }
}
