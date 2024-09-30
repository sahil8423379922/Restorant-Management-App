import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/parsedjson.dart';

// Import your Restaurant model

class RestaurantService {
  // Base API URL
  final String apiUri = "https://www.guildresto.com/api/restaurant";

  // Function to fetch restaurant details
  fetchRestaurant(String id) async {
    final Map<String, dynamic> requestBody = {
      "id": id, // Dynamically pass the ID
    };

    print("Received ID: $id");
    print("Request Payload: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Response Data: $responseData");

        if (responseData.isNotEmpty) {
          // Parse the response data into a Restaurant model
          return responseData;
        } else {
          print("No data found");
          return null;
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error during API call: $error");
      return null;
    }
  }

  fetchRestaurantData() async {
    // Replace '34' with the dynamic ID you want to pass
    final fetchedRestaurant = await fetchRestaurant('34');
    Restaurant resturant = Restaurant.fromJson(fetchedRestaurant);

    if (fetchedRestaurant != null) {
      // No need to call fromJson again
      print("Name of the restaurant = ${resturant.name}");
      return resturant;
    } else {
      print("No restaurant data received");
    }
  }

  //Fetching Resturant menu
  final String api_menu_Uri = "https://www.guildresto.com/api/menu";

  // Function to fetch restaurant details
  fetchRestaurantMenu(String id) async {
    final Map<String, dynamic> requestBody = {
      "resid": id, // Dynamically pass the ID
    };

    print("Received ID: $id");
    print("Request Payload: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        Uri.parse(api_menu_Uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print("Response Data: $responseData");

        if (responseData.isNotEmpty) {
          // Parse the response data into a Restaurant model
          return responseData;
        } else {
          print("No data found");
          return null;
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error during API call: $error");
      return null;
    }
  }

  //resturant menu driver
  fetchRestaurantMenuData(String res_id) async {
    final resturantMenu = await fetchRestaurantMenu(res_id);

    if (resturantMenu != null) {
      // Accessing the data array
      // Extracting the data array

      return resturantMenu;
    } else {
      print("No restaurant data received");
    }
  }
}
