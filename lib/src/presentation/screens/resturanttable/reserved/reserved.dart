import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/TableOrder/tabel.order.dart';
import 'package:resturant_side/src/presentation/widgets/smallbutton.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class Reserved extends StatefulWidget {
  const Reserved({Key? key}) : super(key: key);

  @override
  _ReservedState createState() => _ReservedState();
}

class _ReservedState extends State<Reserved> {
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            itemCount: 3,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? ColorUtils.kcSmoothBlack : ColorUtils.kcWhite,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(-1, 7),
                        blurRadius: 39,
                        color: ColorUtils.kcTransparent.withOpacity(.13))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.grey[600]
                                      : ColorUtils.kcTableNumberColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                '${index + 1 * 3}',
                                style: FontStyleUtilities.h3(
                                    context: context, fontWeight: FWT.semiBold),
                              ),
                            ),
                            SpaceUtils.ks8.height(),
                            Text(
                              'TABLE\nNUMBER',
                              textAlign: TextAlign.center,
                              style: FontStyleUtilities.t4(
                                  context: context, fontWeight: FWT.bold),
                            )
                          ],
                        ),
                        SpaceUtils.ks16.width(),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customer Name',
                                style: FontStyleUtilities.t2(
                                    context: context, fontWeight: FWT.bold)),
                            Text('+1 123456789',
                                style: FontStyleUtilities.t4(
                                    context: context,
                                    fontWeight: FWT.semiBold)),
                            SpaceUtils.ks8.height(),
                            Text('Reserved table for 2',
                                style: FontStyleUtilities.t2(
                                    context: context,
                                    fontWeight: FWT.semiBold)),
                            SpaceUtils.ks7.height(),
                            SmallButton(
                              name: 'Cancel',
                              onTap: () {
                                navigateToPage(context,
                                    page: const TableOrder());
                              },
                              color: ColorUtils.kcPrimary,
                            )
                          ],
                        ))
                      ],
                    ),
                    SpaceUtils.ks30.height(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('June 2, 2021 at 7:00 PM',
                                style: FontStyleUtilities.t2(
                                    context: context, fontWeight: FWT.bold)),
                            SpaceUtils.ks7.height(),
                            SpaceUtils.ks7.height(),
                            Row(
                              children: [
                                SmallButton(
                                  name: 'Reserved',
                                  onTap: () {},
                                  color: ColorUtils.kcPurpleColor,
                                ),
                                SpaceUtils.ks18.width(),
                                SmallButton(
                                  name: 'Arrived',
                                  onTap: () {},
                                  color: ColorUtils.kcGreenColor,
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(IconUtil.call,
                            color: isDark
                                ? ColorUtils.kcWhite
                                : ColorUtils.kcCallIconColor)
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          SpaceUtils.ks120.height()
        ],
      ),
    );
  }
}

List<String> items = [
  ' Soya, Broccoli, Vegetables',
  " Pepper Paneer",
  ' Garlic Bread'
];
