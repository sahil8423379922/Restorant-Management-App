import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/parsedjson.dart';

// Import your Restaurant model

class RestaurantService {
  // Base API URLs
  final String apiUri = "https://www.guildresto.com/api/restaurant";
  final String apiMenuUri = "https://www.guildresto.com/api/menu";
  final String apiPendingOrderUri = "https://www.guildresto.com/api/orderinfo";
  final String apiMenuDetailsUri = "https://www.guildresto.com/api/menudetails";
  final String apiApprovedOrderUri = "https://www.guildresto.com/api/approved";
  final String apiOrderDetailsUri =
      "https://www.guildresto.com/api/orderdetails";
  final String apichangeStatus = "https://www.guildresto.com/api/process";

  // Generic API call function
  Future<dynamic> _apiCall(String uri, Map<String, dynamic> requestBody) async {
    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error during API call: $error");
      return null;
    }
  }

  // Fetch restaurant details
  Future<dynamic> fetchRestaurant(String id) async {
    final Map<String, dynamic> requestBody = {"id": id};
    print("Received ID: $id");
    return await _apiCall(apiUri, requestBody);
  }

  // Fetch restaurant data
  Future<Restaurant?> fetchRestaurantData(String resId) async {
    final fetchedRestaurant = await fetchRestaurant(resId);
    if (fetchedRestaurant != null) {
      return Restaurant.fromJson(fetchedRestaurant);
    } else {
      print("No restaurant data received");
      return null;
    }
  }

  // Fetch restaurant menu
  Future<List<dynamic>> fetchRestaurantMenu(String id) async {
    final Map<String, dynamic> requestBody = {"resid": id};
    print("Received ID: $id");
    return await _apiCall(apiMenuUri, requestBody);
  }

  // Fetch restaurant menu data
  Future<List<dynamic>?> fetchRestaurantMenuData(String resId) async {
    return await fetchRestaurantMenu(resId);
  }

  // Fetch pending orders
  Future<List<dynamic>?> fetchPendingOrders(String id) async {
    final Map<String, dynamic> requestBody = {"resid": id};
    print("Received ID: $id");
    return await _apiCall(apiPendingOrderUri, requestBody);
  }

  // Change Order Status
  Future<bool> ChangeOrderStatus(String id, String phase) async {
    final Map<String, dynamic> requestBody = {"oid": id, "phase": phase};
    print("Received ID: $id");
    print("Received phase: $phase");
    return await _apiCall(apichangeStatus, requestBody);
  }

  // Fetch menu details
  Future<dynamic> fetchMenuDetails(String id) async {
    final Map<String, dynamic> requestBody = {"menuid": id};
    print("Received ID: $id");
    return await _apiCall(apiMenuDetailsUri, requestBody);
  }

  // Fetch approved orders
  Future<List<dynamic>?> fetchApprovedOrders(String id) async {
    final Map<String, dynamic> requestBody = {"resid": id};
    print("Received ID: $id");
    return await _apiCall(apiApprovedOrderUri, requestBody);
  }

  // Fetch order details
  Future<List<dynamic>?> fetchOrderDetails(String id) async {
    final Map<String, dynamic> requestBody = {"orderid": id};
    print("Received ID: $id");
    return await _apiCall(apiOrderDetailsUri, requestBody);
  }
}
