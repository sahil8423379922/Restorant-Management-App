import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resturant_side/db/DatabaseHelper.dart';
import 'package:resturant_side/src/model/items/response.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/Home/mainhome.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map<String, dynamic>? userData;

  final TextEditingController _emailcotroller = TextEditingController();
  final TextEditingController _passwordcontrolle = TextEditingController();
  final Map<String, dynamic> responseData = {};

  Future<void> loginUser(String email, String password) async {
    const String apiUri = "https://www.guildresto.com/api/login";

    // API payload
    final Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };

    // Log received values
    print("Received Email: $email");
    print("Received Password: $password");

    // Log the request body
    print("Request Payload: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Response Data: $responseData");

        if (responseData.length > 1) {
          parseData(responseData);
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (error) {
      print("Error during API call: $error");
    }
  }

  void parseData(Map<String, dynamic> responseData) {
    print("Parse Data Function is called");
    //Map<String, dynamic> userMap = json.decode(responseData);
    User user = User.fromJson(responseData);
    print('User ID =${user.id}');
    print('User Name =${user.name}');
    print('User Email =${user.email}');
    print('User Phone =${user.phone}');
    print('User Password =${user.password}');
    print('User Role =${user.roleId}');
    print('User Status =${user.status}');

    DatabaseHelper.instance.insertUser({
      'userid': user.id,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'password': user.password,
      'role': user.roleId,
      'status': user.status
    });

    navigateToPage(context, page: const HomeMain());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpaceUtils.ks60.height(),
                  Text(
                    'Log In',
                    style: FontStyleUtilities.h2(
                        context: context, fontWeight: FWT.semiBold),
                  ),
                  SpaceUtils.ks65.height(),
                  MasterTextField(
                    tittle: 'Email Address',
                    hint: 'Enter Email Address',
                    controller: _emailcotroller,
                  ),
                  SpaceUtils.ks24.height(),
                  MasterTextField(
                      tittle: 'Password',
                      hint: 'Enter Password',
                      controller: _passwordcontrolle,
                      obscureText: true),
                  SpaceUtils.ks50.height(),
                  MasterButton(
                    onTap: () {
                      String email = _emailcotroller.text;
                      String password = _passwordcontrolle.text;
                      loginUser(email, password);
                    },
                    tittle: 'LOG IN',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
