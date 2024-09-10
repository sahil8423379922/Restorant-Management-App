import 'package:flutter/material.dart';

import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';

class DropDownBox extends StatefulWidget {
  const DropDownBox({
    Key? key,
    required this.width,
    this.height,
    required this.item,
    this.style = const TextStyle(
      fontFamily: 'Sands',
      color: ColorUtils.kcBlueButton,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    required this.value,
    this.decoration,
  }) : super(key: key);

  final List<String> item;
  final ValueChanged<String?> value;

  ///FOR UI CONFIGURATION ...
  final BoxDecoration? decoration;
  final TextStyle? style;
  final double? width, height;
  @override
  _DropDownBoxState createState() => _DropDownBoxState();
}

class _DropDownBoxState extends State<DropDownBox> {
  String dropdownValue = "";
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.item[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: widget.decoration,
          height: widget.height ?? 40,
          width: widget.width,
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            icon: const Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ))),
            iconSize: 30,
            elevation: 16,
            style: FontStyleUtilities.t2(
              fontWeight: FWT.semiBold,
              context: context,
            ),
            underline: Container(
              color: ColorUtils.kcTransparent,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                dropdownValue = newValue;
                widget.value(newValue);
                setState(() {});
              }
            },
            items: widget.item.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
