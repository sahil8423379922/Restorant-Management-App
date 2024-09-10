import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';

/// THIS ENUM IS USED TO MANAGE FONT_WEIGHT...
enum FWT { light, regular, medium, semiBold, bold, extrabold }

/// THIS CLASS IS USED TO MANAGE FONT_STYLES USED IN THE APPLICATION...
class FontStyleUtilities {
  /// THIS FUNCTION RETURNS FONT_WEIGHT ACCORDING TO USER REQUIREMENT(FROM ENUM)...
  static FontWeight getFontWeight({FWT? fontWeight = FWT.regular}) {
    switch (fontWeight) {
      case FWT.extrabold:
        return FontWeight.w800;
      case FWT.bold:
        return FontWeight.w700;
      case FWT.semiBold:
        return FontWeight.w600;
      case FWT.medium:
        return FontWeight.w500;
      case FWT.regular:
        return FontWeight.w400;
      case FWT.light:
        return FontWeight.w300;
      default:
        return FontWeight.w400;
    }
  }

  /// FONTSTYLE FOR FONT SIZE 34
  static TextStyle h1(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 34,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 30
  static TextStyle h2(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 30,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 24
  static TextStyle h3(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 24,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 20
  static TextStyle h4(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 20,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 17
  static TextStyle h5(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 17,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 16
  static TextStyle h6(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 16,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 15
  static TextStyle t1(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 15,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 14
  static TextStyle t2(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 13
  static TextStyle t3(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 13,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 12
  static TextStyle t4(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 12,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 11
  static TextStyle t5(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 11,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 14
  static TextStyle l1(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 14
  static TextStyle p1(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 14,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 13
  static TextStyle p2(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 13,
    );
  }

  /// FONTSTYLE FOR FONT SIZE 12
  static TextStyle p3(
      {Color? fontColor,
      FWT? fontWeight = FWT.regular,
      required BuildContext context}) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: 'Sands',
      color: isDark
          ? fontColor ?? ColorUtils.kcWhite
          : fontColor ?? ColorUtils.kcBlueButton,
      fontWeight: getFontWeight(fontWeight: fontWeight),
      fontSize: 12,
    );
  }
}
