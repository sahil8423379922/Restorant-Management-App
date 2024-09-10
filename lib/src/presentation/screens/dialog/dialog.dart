import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    required this.tittle,
    required this.subTittle,
    required this.buttonText,
    required this.dialogThemeColor,
    required this.avatarChild,
    required this.onTap,
    this.style,
  }) : super(key: key);
  final String tittle, subTittle, buttonText;
  final Color dialogThemeColor;
  final Widget avatarChild;
  final VoidCallback onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: ColorUtils.kcTransparent,
      width: double.infinity,
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
                padding: const EdgeInsets.only(
                    top: 35, left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                  color: isDark ? ColorUtils.kcSmoothBlack : ColorUtils.kcWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      tittle,
                      textAlign: TextAlign.center,
                      style: FontStyleUtilities.h4(
                          context: context, fontWeight: FWT.semiBold),
                    ),
                    SpaceUtils.ks16.height(),
                    Text(
                      subTittle,
                      style: FontStyleUtilities.t1(
                          context: context, fontWeight: FWT.medium),
                    ),
                    SpaceUtils.ks24.height(),
                    MasterButton(
                      tittle: buttonText,
                      onTap: onTap,
                      color: dialogThemeColor,
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: dialogThemeColor,
              child: avatarChild,
            ),
          )
        ],
      ),
    );
  }
}
