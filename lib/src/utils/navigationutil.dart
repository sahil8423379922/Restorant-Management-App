import 'package:flutter/cupertino.dart';
import 'package:resturant_side/src/presentation/screens/Home/mainhome.dart';

navigateToPage(BuildContext context, {required Widget page}) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
}

popToTheHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => const HomeMain()),
      (route) => false);
}
