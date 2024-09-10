import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';

class CustomIconButton extends StatelessWidget {
  final double? size;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  const CustomIconButton(
      {Key? key,
      this.size = 24,
      required this.onTap,
      this.padding,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: MaterialButton(
        onPressed: onTap,
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
