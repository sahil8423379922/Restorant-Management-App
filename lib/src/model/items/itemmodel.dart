
import 'package:json_annotation/json_annotation.dart';

part 'itemmodel.g.dart';

@JsonSerializable()
class ItemModel {
  ItemModel(
      {required this.name,
      required this.image,
      required this.price,
      required this.isVeg});
  final String name, image;
  final int price;
  final bool isVeg;
}
