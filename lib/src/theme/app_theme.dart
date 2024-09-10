import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../presentation/constatns/colors.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    primarySwatch: Colors.red,
    primaryColor: ColorUtils.kcWhite,
    appBarTheme: const AppBarTheme(backgroundColor: ColorUtils.kcbackDarkColor),
    navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: ColorUtils.kcBlack),
    brightness: Brightness.dark,
    primaryTextTheme: Typography(platform: TargetPlatform.android).white,
    textTheme: Typography(platform: TargetPlatform.android).white,
    scaffoldBackgroundColor: ColorUtils.kcbackDarkColor,
    cardColor: ColorUtils.kcBlueButton,
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: ColorUtils.kcPrimary, width: 3))),
    dividerColor: ColorUtils.kcTextFieldBorder,
    dialogBackgroundColor: ColorUtils.kcBlueButton,
    dividerTheme: const DividerThemeData(color: Colors.transparent),
    iconTheme: const IconThemeData(color: ColorUtils.kcWhite),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(
            ((states) => ColorUtils.kcBlueButton),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.transparent)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              const TextStyle(color: ColorUtils.kcPrimary)),
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorUtils.kcWhite)),
    ),

    // buttonTheme: const ButtonThemeData(
    //     textTheme: ButtonTextTheme.primary,
    //     buttonColor: ColorUtils.kcPrimary),
  );
  static final lightTheme = ThemeData(
    primaryColor: ColorUtils.kcPrimary,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: ColorUtils.kcWhite),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: ColorUtils.kcPrimary, width: 3))),
    buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary, buttonColor: ColorUtils.kcWhite),
    textTheme: Typography(platform: TargetPlatform.android).black,
    scaffoldBackgroundColor: ColorUtils.kcWhite,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              const TextStyle(color: ColorUtils.kcWhite)),
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorUtils.kcPrimary)),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: ColorUtils.kcWhite),
    navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: Colors.white),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(
            ((states) => ColorUtils.kcCallIconColor.withOpacity(0.2)),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.transparent)),
    ),
    cardColor: ColorUtils.kcWhite,
    dialogBackgroundColor: ColorUtils.kcWhite,
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  // SystemUiOverlayStyle themeModeUi = ThemeMode.system == ThemeMode.dark
  //     ? SystemUiOverlayStyle.dark
  //     : SystemUiOverlayStyle.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;
  // bool get isSystemUiModeDark => themeModeUi == SystemUiOverlayStyle.dark;

  void toggleTheme(bool isTrue) {
    themeMode = isTrue ? ThemeMode.dark : ThemeMode.light;
    // themeModeUi =
    //     isTrue ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
    notifyListeners();
  }
}
