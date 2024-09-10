import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/textstyle.dart';

class MasterButton extends StatelessWidget {
  const MasterButton({
    Key? key,
    this.isBusy = false,
    required this.onTap,
    required this.tittle,
    this.isOutlined = false,
    this.color = ColorUtils.kcPrimary,
    this.radius = 10,
  }) : super(key: key);
  final bool? isBusy;
  final VoidCallback onTap;
  final String tittle;
  final bool? isOutlined;
  final Color? color;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 8,
        shadowColor: isDark
            ? Colors.grey.withOpacity(.2)
            : Colors.black.withOpacity(.13),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)),
        child: Container(
            alignment: Alignment.center,
            height: 48,
            width: double.infinity,
            decoration: isOutlined!
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(radius!),
                    color: isDark ? ColorUtils.kcBlack : ColorUtils.kcWhite,
                    border: Border.all(color: color!))
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(radius!),
                    color: color!),
            child: isBusy!
                ? SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(
                      color: isOutlined! ? color! : ColorUtils.kcWhite,
                    ),
                  )
                : Text(
                    tittle.toUpperCase(),
                    style: FontStyleUtilities.t1(
                        context: context,
                        fontColor: isOutlined!
                            ? ColorUtils.kcPrimary
                            : ColorUtils.kcWhite,
                        fontWeight: FWT.semiBold),
                  )),
      ),
    );
  }
}
