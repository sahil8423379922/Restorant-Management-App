import 'package:flutter/foundation.dart';

class CategoriesModel extends ValueListenable {
  static List<String> _value = <String>['Lunch', 'Dinner'];

  ValueNotifier<List<String>> notifier = ValueNotifier<List<String>>(_value);

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  get value => _value;
}
