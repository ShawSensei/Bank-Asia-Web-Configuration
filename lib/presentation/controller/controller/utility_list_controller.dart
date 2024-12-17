import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common.dart';
import '../../../data/data_sources/api/api/ComponentService.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../../domain/model/response_model/utility_list_res_model.dart';



class UtilityListController extends GetxController {
  final String baseUrl = "http://10.11.201.137:8085"; // Replace with your API URL
  var utilities = <Utility>[].obs;

  final PageInfo pageInfo;
  final ComponentService _componentService;

  UtilityListController(this.pageInfo, this._componentService);

  @override
  void onInit() {
    super.onInit();
    fetchBillerList(); // Call without context
  }

  // Fetch Biller List
  Future<void> fetchBillerList() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/bill-pay/v1/bill-pay/utilities"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final utilityListResponse = UtilityListResModel.fromJson(data);

        // Update the observable list with fetched utilities
        utilities.value = utilityListResponse.utilities;
      } else {
        debugPrint("Error fetching utilities: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error fetching biller list: $error");
    }
  }

  // Fetch with Snackbar (optional for UI calls)
  Future<void> fetchBillerListWithSnackbar(BuildContext context) async {
    await fetchBillerList(); // Fetch the data
    Common.showFlutterSnackbar(context, "Utilities fetched successfully!", Colors.green);
  }

  // Delete Component
  Future<void> deleteComponent(String id, PageInfo info, BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/components/${info.pageRoute}/$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Re-fetch the list after deletion
        await fetchBillerList();
        Common.showFlutterSnackbar(context, "Component deleted successfully!", Colors.green);
      } else {
        debugPrint("Error deleting component: ${response.statusCode}");
        Common.showFlutterSnackbar(context, "Error deleting component", Colors.red);
      }
    } catch (error) {
      debugPrint("Error deleting component: $error");
      Common.showFlutterSnackbar(context, "Error deleting component", Colors.red);
    }
  }
}
