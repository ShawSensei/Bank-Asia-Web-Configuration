import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../common/common.dart';
import '../../../domain/model/request_model/page_info.dart';
import '../../../domain/model/response_model/page_response.dart';


class AddPageController extends GetxController {
  final String baseUrl = "https://api.example.com"; // Replace with your API URL

  var pageLabelTextFieldController = TextEditingController();
  var pageList = <PageResponse>[].obs; // List of response model objects

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  /// Save Page Data
  Future<void> saveData(BuildContext context) async {
    if (pageLabelTextFieldController.text.isEmpty) {
      Common.showFlutterSnackbar(context, "Please enter page name.", Colors.red);
      return;
    }

    final pageInfo = PageInfo(
      pageName: pageLabelTextFieldController.text,
      pageRoute: convertToSlug(pageLabelTextFieldController.text),
    );

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/page-name"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pageInfo.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          pageLabelTextFieldController.clear();
          Get.snackbar(
            "Success",
            responseData['message'] ?? "Data saved successfully!",
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          fetchData(); // Refresh data
        } else {
          Common.showFlutterSnackbar(context, responseData['message'] ?? "Error occurred", Colors.amber.shade400);
        }
      } else {
        Common.showFlutterSnackbar(context, "Error saving data", Colors.amber.shade400);
      }
    } catch (error) {
      debugPrint("Error saving data: $error");
      Common.showFlutterSnackbar(context, "Error saving data", Colors.amber.shade400);
    }
  }

  /// Fetch Data Using Request-Response Model
  /// Fetch Data Using Request-Response Model
  Future<void> fetchData() async {
    try {
      // Uncomment the next block to use dummy data for testing

      final mockResponse = [
        {
          "id": "1",
          "PageName": "Home",
          "PageRoute": "home",
        },
        {
          "id": "2",
          "PageName": "About",
          "PageRoute": "about",
        },
        {
          "id": "3",
          "PageName": "Contact",
          "PageRoute": "contact",
        },
      ];

      pageList.value = mockResponse.map((json) {
        return PageResponse.fromJson(json);
      }).toList();
      return;


      // Actual API call

      final pageInfo = PageInfo(
        pageName: "", // Optional filter criteria
        pageRoute: "", // Optional filter criteria
      );

      final response = await http.post(
        Uri.parse("$baseUrl/page-name"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(pageInfo.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          pageList.value = (responseData['data'] as List<dynamic>).map((json) {
            return PageResponse.fromJson(json);
          }).toList();
        } else {
          debugPrint("Error in response: ${responseData['message']}");
        }
      } else {
        debugPrint("Error fetching data: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error fetching data: $error");
    }
  }


  /// Delete a Page
  Future<void> deleteComponent(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/page-name/$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        fetchData(); // Refresh the list after deletion
      } else {
        debugPrint("Error deleting component: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error deleting component: $error");
    }
  }

  /// Convert Input String to Slug
  String convertToSlug(String input) {
    return input.toLowerCase().replaceAll(' ', '-');
  }
}
