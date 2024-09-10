import 'package:flutter/material.dart';
import 'package:resturant_side/src/extensions/heighextension.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/constatns/textstyle.dart';

typedef OnSubmitted = Function(String);

class MasterTextField extends StatefulWidget {
  const MasterTextField(
      {Key? key,
      required this.tittle,
      this.hint,
      this.controller,
      this.height,
      this.onSubmitted,
      this.maxLines,
      this.obscureText})
      : super(key: key);
  final String tittle;
  final String? hint;
  final TextEditingController? controller;
  final OnSubmitted? onSubmitted;
  final double? height;
  final int? maxLines;
  final bool? obscureText;

  @override
  State<MasterTextField> createState() => _MasterTextFieldState();
}

class _MasterTextFieldState extends State<MasterTextField> {
  final OutlineInputBorder border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorUtils.kcTextFieldBorder,
      ),
      borderRadius: BorderRadius.circular(8));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.tittle,
          style: FontStyleUtilities.h6(context: context, fontWeight: FWT.bold),
        ),
        SpaceUtils.ks10.height(),
        SizedBox(
          height: widget.height ?? 48,
          child: TextField(
              maxLines: widget.maxLines ?? 1,
              obscureText: widget.obscureText ?? false,
              onSubmitted: widget.onSubmitted,
              controller: widget.controller,
              scrollPadding: const EdgeInsets.all(4),
              cursorColor: ColorUtils.kcPrimary,
              decoration: InputDecoration(
                  border: border,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorUtils.kcPrimary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  hintText: widget.hint,
                  hintStyle: FontStyleUtilities.p1(
                      context: context, fontWeight: FWT.medium))),
        )
      ],
    );
  }
}
