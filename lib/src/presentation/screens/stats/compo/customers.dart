import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

class Customers extends StatelessWidget {
  const Customers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customers',
                style: FontStyleUtilities.t1(
                  fontWeight: FWT.extrabold,
                  context: context,
                ),
              ),
              SpaceUtils.ks10.height(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        '45',
                        style: FontStyleUtilities.h3(
                          fontWeight: FWT.bold,
                          context: context,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 9,
                            width: 9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.5),
                                color: ColorUtils.kcMediumRed),
                          ),
                          5.0.width(),
                          Text(
                            'New',
                            style: FontStyleUtilities.t2(
                              fontWeight: FWT.semiBold,
                              context: context,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SpaceUtils.ks10.width(),
                  Column(
                    children: [
                      Text(
                        '15',
                        style: FontStyleUtilities.h3(
                          fontWeight: FWT.bold,
                          context: context,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 9,
                            width: 9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.5),
                                color: ColorUtils.kcLightRed),
                          ),
                          5.0.width(),
                          Text(
                            'Repeat',
                            style: FontStyleUtilities.t2(
                              fontWeight: FWT.semiBold,
                              context: context,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 112,
            width: 112,
            child: Transform(
              origin: const Offset(50, -58),
              transform: Matrix4.identity()..rotateY(1 * 3.14),
              child: CircularPercentIndicator(
                startAngle: 0,
                radius: 56,
                lineWidth: 18,
                center: Transform(
                  origin: const Offset(15, -58),
                  transform: Matrix4.identity()..rotateY(1 * 3.14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '60',
                        style: FontStyleUtilities.h3(
                          fontColor: ColorUtils.kcPrimary,
                          fontWeight: FWT.bold,
                          context: context,
                        ),
                      ),
                      Text(
                        'Total',
                        style: FontStyleUtilities.t3(
                          fontColor: ColorUtils.kcPrimary,
                          fontWeight: FWT.medium,
                          context: context,
                        ),
                      )
                    ],
                  ),
                ),
                progressColor: ColorUtils.kcMediumRed.withOpacity(.90),
                percent: .65,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: ColorUtils.kcLightRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
