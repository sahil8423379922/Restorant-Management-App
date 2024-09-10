import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/widgets/tagwidget.dart';
import 'package:resturant_side/src/utils/iconutil.dart';

class Complete extends StatefulWidget {
  const Complete({Key? key}) : super(key: key);

  @override
  _CompleteState createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
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
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customer Name',
                                style: FontStyleUtilities.t1(
                                    context: context, fontWeight: FWT.bold)),
                            Text('+1 123456789',
                                style: FontStyleUtilities.t3(
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
                        )),
                        Text(
                          '\$210.00',
                          style: FontStyleUtilities.h5(
                              context: context, fontWeight: FWT.bold),
                        ),
                      ],
                    ),
                    SpaceUtils.ks30.height(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('COMPLETED ON',
                                style: FontStyleUtilities.t2(
                                    context: context,
                                    fontWeight: FWT.extrabold)),
                            Text('June 2, 2021 at 7:00 PM',
                                style: FontStyleUtilities.t2(
                                    context: context,
                                    fontWeight: FWT.semiBold)),
                            SpaceUtils.ks10.height(),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          IconUtil.call,
                          color: isDark
                              ? ColorUtils.kcWhite
                              : ColorUtils.kcCallIconColor,
                        )
                      ],
                    ),
                    Text('Rated',
                        style: FontStyleUtilities.t1(
                            context: context, fontWeight: FWT.bold)),
                    SpaceUtils.ks7.height(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'asset/icons/happy.svg',
                          height: 27,
                          color: const Color(0xff08C25E),
                        ),
                        SpaceUtils.ks16.width(),
                        Text('Satisfied',
                            style: FontStyleUtilities.t1(
                                context: context, fontWeight: FWT.bold)),
                        const Spacer(),
                        const TagWidget(
                          tagName: TagName.COMP,
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          SpaceUtils.ks120.height(),
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
