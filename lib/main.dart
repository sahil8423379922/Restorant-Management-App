import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:resturant_side/db/DatabaseHelper.dart';
import 'package:resturant_side/src/presentation/screens/Home/mainhome.dart';
import 'package:resturant_side/src/presentation/screens/authentication/login/login.dart';
import 'package:provider/provider.dart';
import 'src/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_user_already_logged_in();
  }

  bool state = false;

  Future<void> check_user_already_logged_in() async {
    List<Map<String, dynamic>> users = await DatabaseHelper.instance.getUsers();
    if (users.length > 0) {
      setState(() {
        state = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return OverlaySupport(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Restaurant',
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              home: state ? HomeMain() : Login(),
            ),
          );
        });
  }
}
