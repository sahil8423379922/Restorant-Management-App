import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

class TotalOrders extends StatelessWidget {
  const TotalOrders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return CommonShadowContainer(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Orders',
                  style: FontStyleUtilities.h5(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: isDark
                          ? ColorUtils.kcWhite
                          : ColorUtils.kcBlueButton.withOpacity(1)),
                ),
                Text(
                  '135',
                  style: FontStyleUtilities.h2(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: ColorUtils.kcPrimary),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'item sold',
                  style: FontStyleUtilities.h5(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: isDark
                          ? ColorUtils.kcWhite
                          : ColorUtils.kcBlueButton.withOpacity(1)),
                ),
                Text(
                  '556',
                  style: FontStyleUtilities.h2(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: ColorUtils.kcPrimary),
                ),
              ],
            ),
            const Spacer(),
          ],
        ));
  }
}
