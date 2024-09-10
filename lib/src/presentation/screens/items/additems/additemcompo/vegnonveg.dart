import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';

class VegNonVeg extends StatefulWidget {
  const VegNonVeg({Key? key}) : super(key: key);

  @override
  State<VegNonVeg> createState() => _VegNonVegState();
}

class _VegNonVegState extends State<VegNonVeg> {
  onTap(int index) {
    selectedIndex = index;
    setState(() {});
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: MasterButton(
          onTap: () {
            onTap(0);
          },
          tittle: 'Veg',
          isOutlined: selectedIndex != 0,
        )),
        SpaceUtils.ks16.width(),
        Expanded(
            child: MasterButton(
          onTap: () {
            onTap(1);
          },
          tittle: 'Non-Veg',
          isOutlined: selectedIndex != 1,
        ))
      ],
    );
  }
}
