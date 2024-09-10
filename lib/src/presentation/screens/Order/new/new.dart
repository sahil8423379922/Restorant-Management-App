import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/presentation/widgets/tagwidget.dart';
import 'package:resturant_side/src/utils/iconutil.dart';

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        )),
                        Text(
                          '\$210.00',
                          style: FontStyleUtilities.h5(
                              context: context, fontWeight: FWT.bold),
                        ),
                        // SvgPicture.asset(IconUtil.call,
                        //     color: ColorUtils.kcBlueButton.withOpacity(.75))
                      ],
                    ),
                    SpaceUtils.ks30.height(),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('June 2, 2021 at 7:00 PM',
                                style: FontStyleUtilities.t2(
                                    context: context, fontWeight: FWT.bold)),
                            SpaceUtils.ks7.height(),
                            const TagWidget(
                              tagName: TagName.DINEIN,
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(IconUtil.call,
                            color: isDark
                                ? ColorUtils.kcWhite
                                : ColorUtils.kcCallIconColor)
                      ],
                    ),
                    SpaceUtils.ks18.height(),
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                              child: MasterButton(
                                  radius: 25,
                                  isOutlined: false,
                                  tittle: 'CANCEL',
                                  onTap: () {})),
                          SpaceUtils.ks18.width(),
                          Expanded(
                              child: MasterButton(
                                  radius: 25,
                                  tittle: 'ACCEPT',
                                  color: ColorUtils.kcGreenColor,
                                  onTap: () {})),
                        ],
                      ),
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
