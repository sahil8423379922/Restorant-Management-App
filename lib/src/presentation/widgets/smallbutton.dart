import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';

class SmallButton extends StatelessWidget {
  const SmallButton(
      {Key? key,
      required this.name,
      this.color = ColorUtils.kcBlueButton,
      required this.onTap})
      : super(key: key);
  final String name;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: SizedBox(
        height: 15,
        child: MaterialButton(
          splashColor: ColorUtils.kcTransparent,
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Text(
            name.toUpperCase(),
            style: FontStyleUtilities.t4(
                context: context,
                fontWeight: FWT.extrabold,
                fontColor: ColorUtils.kcWhite),
          ),
        ),
      ),
    );
  }
}

class MyButton extends MaterialButton {
  const MyButton(this.onTap, {Key? key}) : super(key: key, onPressed: onTap);
  final VoidCallback onTap;
}
