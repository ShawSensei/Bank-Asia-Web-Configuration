import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/request_model/page_info.dart';
import '../model/response_model/component_response.dart';

class ComponentController extends GetxController {
  final String baseUrl = "https://api.example.com"; // Replace with your API URL
  var components = <ComponentResponse>[].obs;

  final PageInfo pageInfo;

  ComponentController(this.pageInfo) {
    fetchData(pageInfo);
  }

  Future<void> fetchData(PageInfo info) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/components/${info.pageRoute}"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        components.value = responseData.map((json) {
          return ComponentResponse.fromJson(json);
        }).toList();
      } else {
        debugPrint("Error fetching components: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error fetching components: $error");
    }
  }

  Future<void> deleteComponent(String id, PageInfo info) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/components/${info.pageRoute}/$id"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        fetchData(info); // Refresh the list after deletion
      } else {
        debugPrint("Error deleting component: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error deleting component: $error");
    }
  }
}
