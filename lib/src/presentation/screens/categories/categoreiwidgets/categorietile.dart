import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/textstyle.dart';
import 'package:resturant_side/src/presentation/widgets/customiconbutton.dart';

class CategoriesTile extends StatelessWidget {
  const CategoriesTile(
      {Key? key, required this.nameOfCategory, required this.onTap})
      : super(key: key);
  final String nameOfCategory;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                nameOfCategory,
                style: FontStyleUtilities.h6(
                  fontWeight: FWT.medium,
                  context: context,
                ),
              ),
              CustomIconButton(
                size: 30,
                onTap: onTap,
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: ColorUtils.kcPrimary,
                ),
              )
            ]),
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorUtils.kcTextFieldBorder)));
  }
}
