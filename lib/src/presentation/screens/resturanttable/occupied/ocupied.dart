import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/TableOrder/tabel.order.dart';
import 'package:resturant_side/src/presentation/widgets/smallbutton.dart';
import 'package:resturant_side/src/presentation/widgets/tagwidget.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class Occupied extends StatefulWidget {
  const Occupied({Key? key}) : super(key: key);

  @override
  _OccupiedState createState() => _OccupiedState();
}

class _OccupiedState extends State<Occupied> {
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
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (context, i) => Row(
                                      children: [
                                        Text(
                                          '${index + i + 1} x ${items[i]} ',
                                          style: FontStyleUtilities.t2(
                                              context: context,
                                              fontWeight: FWT.semiBold),
                                        ),
                                      ],
                                    ))
                          ],
                        ))
                      ],
                    ),
                    SpaceUtils.ks30.height(),
                    Text('June 2, 2021 at 7:00 PM',
                        style: FontStyleUtilities.t2(
                            context: context, fontWeight: FWT.bold)),
                    SpaceUtils.ks7.height(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '05:37',
                          style: FontStyleUtilities.h3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks16.width(),
                        const TagWidget(
                          tagName: TagName.OCCU,
                        ),
                        const Spacer(),
                        Text(
                          '\$210.00',
                          style: FontStyleUtilities.h5(
                              context: context, fontWeight: FWT.bold),
                        ),
                      ],
                    ),
                    SpaceUtils.ks30.height(),
                    Row(
                      children: [
                        SmallButton(
                            name: 'Edit order',
                            onTap: () {
                              navigateToPage(context, page: const TableOrder());
                            }),
                        SpaceUtils.ks18.width(),
                        SmallButton(name: 'Free Table', onTap: () {}),
                      ],
                    )
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
