import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/request_model/component_request.dart';

class ComponentService {
  final String baseUrl = "https://api.example.com"; // Replace with your actual API base URL

  // Save component
  Future<Map<String, dynamic>> saveComponent(String pageRoute, ComponentRequest request) async {
    debugPrint(request.toJson().toString());
    final response = await http.post(
      Uri.parse("$baseUrl/components/$pageRoute"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),  // Convert ComponentRequest to Map<String, dynamic>

    );

    return jsonDecode(response.body);  // Assuming the API returns a JSON response
  }

  // General method to handle API requests
  Future<Map<String, dynamic>> apiRequest(
      String endpoint, {
        String method = 'GET',  // Default is GET
        Map<String, String>? headers,
        dynamic body,
      }) async {
    final Uri url = Uri.parse("$baseUrl/$endpoint");

    try {
      http.Response response;

      // Choose the HTTP method based on the 'method' parameter
      if (method == 'POST') {
        response = await http.post(
          url,
          headers: headers ?? {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );
      } else if (method == 'PUT') {
        response = await http.put(
          url,
          headers: headers ?? {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );
      } else if (method == 'DELETE') {
        response = await http.delete(url, headers: headers);
      } else { // Default to GET
        response = await http.get(url, headers: headers);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If the API returns a successful status code, return the response body as a map
        return jsonDecode(response.body);
      } else {
        // If the API returns an error, throw an exception with the error message
        throw Exception('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      // Handle any exceptions (e.g., network issues, timeouts, etc.)
      throw Exception('Failed to make API request: $error');
    }
  }

  // Specialized method for saving components (POST request)
  Future<Map<String, dynamic>> saveItem(String pageRoute, Map<String, dynamic> requestBody) async {
    return apiRequest(
      "components/$pageRoute",  // Endpoint
      method: 'POST',  // HTTP method
      body: requestBody,  // Body data (e.g., request model)
    );
  }

  // Specialized method for fetching a component (GET request)
  Future<Map<String, dynamic>> getComponent(String componentId) async {
    return apiRequest(
      "components/$componentId",  // Endpoint
      method: 'GET',  // HTTP method
    );
  }

  // Specialized method for updating a component (PUT request)
  Future<Map<String, dynamic>> updateComponent(String componentId, Map<String, dynamic> updatedData) async {
    return apiRequest(
      "components/$componentId",  // Endpoint
      method: 'PUT',  // HTTP method
      body: updatedData,  // Body data for updating the component
    );
  }

  // Specialized method for deleting a component (DELETE request)
  Future<Map<String, dynamic>> deleteComponent(String componentId) async {
    return apiRequest(
      "components/$componentId",  // Endpoint
      method: 'DELETE',  // HTTP method
    );
  }
}
