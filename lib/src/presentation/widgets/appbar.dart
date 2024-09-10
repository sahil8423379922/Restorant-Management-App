import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/textstyle.dart';

AppBar buildAppBar(
  BuildContext context, {
  required String tittle,
}) {
  var isDark = Theme.of(context).brightness == Brightness.dark;
  return AppBar(
      centerTitle: true,
      elevation: 0,
      foregroundColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
      title: Text(
        tittle,
        style: FontStyleUtilities.h4(fontWeight: FWT.bold, context: context),
      ));
}
