import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/tagwidget.dart';
import 'package:resturant_side/src/utils/iconutil.dart';

class Active extends StatefulWidget {
  const Active({Key? key}) : super(key: key);

  @override
  _ActiveState createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
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
                      ],
                    ),
                    SpaceUtils.ks20.height(),
                    Text('TRACK',
                        style: FontStyleUtilities.t2(
                            context: context, fontWeight: FWT.semiBold)),
                    SpaceUtils.ks10.height(),
                    SizedBox(
                        height: 200,
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: TrackerWidget(status: 2),
                            ),
                            SpaceUtils.ks16.width(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  TrackerWidgetText(
                                      titel: "Order confirmed",
                                      sutite: "June 2, 2021 at 7:00 PM"),
                                  TrackerWidgetText(
                                      titel: "Order Prepared",
                                      sutite: "June 2, 2021 at 7:00 PM"),
                                  TrackerWidgetText(
                                      titel: "Order In Progress",
                                      sutite: "___"),
                                  TrackerWidgetText(
                                      titel: "Delivered", sutite: "___"),
                                ],
                              ),
                            )
                          ],
                        )),
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
                        const TagWidget(tagName: TagName.INPROGRESS),
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

class TrackerWidget extends StatelessWidget {
  const TrackerWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  final int status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotatedBox(
              quarterTurns: 1,
              child: LinearPercentIndicator(
                percent: .33 * status,
                backgroundColor: Colors.grey[200],
                lineHeight: 2.5,
                animationDuration: 2000,
                progressColor: ColorUtils.kcGreenColor,
                animation: true,
                animateFromLastPercent: true,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NodeOfPercent(
                nodeNumber: 0,
                selctone: status >= 0,
              ),
              NodeOfPercent(
                nodeNumber: 1,
                selctone: status >= 1,
              ),
              NodeOfPercent(
                nodeNumber: 2,
                selctone: status >= 2,
              ),
              NodeOfPercent(
                nodeNumber: 3,
                selctone: status >= 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrackerWidgetText extends StatelessWidget {
  const TrackerWidgetText({Key? key, required this.titel, required this.sutite})
      : super(key: key);
  final String titel, sutite;

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titel,
          style: FontStyleUtilities.t2(
              context: context,
              fontWeight: FWT.semiBold,
              fontColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlack),
        ),
        Text(sutite,
            style: FontStyleUtilities.t4(
                context: context,
                fontWeight: FWT.semiBold,
                fontColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlack)),
      ],
    );
  }
}

class NodeOfPercent extends StatefulWidget {
  const NodeOfPercent(
      {Key? key, required this.nodeNumber, required this.selctone})
      : super(key: key);
  final bool selctone;
  final int nodeNumber;

  @override
  State<NodeOfPercent> createState() => _NodeOfPercentState();
}

class _NodeOfPercentState extends State<NodeOfPercent> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 100,
      ),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
          color: widget.selctone ? ColorUtils.kcGreenColor : ColorUtils.kcWhite,
          borderRadius: BorderRadius.circular(1),
          border: Border.all(
              color:
                  widget.selctone ? ColorUtils.kcGreenColor : Colors.grey[300]!,
              width: 1)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Icon(
            Icons.done,
            size: 12,
            color:
                widget.selctone ? ColorUtils.kcWhite : ColorUtils.kcTransparent,
          ),
        ),
      ),
    );
  }
}
