import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

class TotalStats extends StatefulWidget {
  const TotalStats({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalStats> createState() => _TotalStatsState();
}

class _TotalStatsState extends State<TotalStats>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              StatData(
                  percent: 50, color: ColorUtils.kcPrimary, tag: 'Dine in'),
              StatData(
                  percent: 20, color: ColorUtils.kcMediumRed, tag: 'Take Away'),
              StatData(
                  percent: 30, color: ColorUtils.kcLightRed, tag: 'Delivery'),
            ],
          ),
          SizedBox(
            height: 180,
            width: 150,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => PieChart(
                    PieChartData(
                        sections: [
                          PieChartSectionData(
                              value: 50 * _controller.value,
                              radius: 20,
                              showTitle: false,
                              color: ColorUtils.kcPrimary),
                          PieChartSectionData(
                              value: 30,
                              radius: 20,
                              showTitle: false,
                              color: ColorUtils.kcLightRed),
                          PieChartSectionData(
                              value: 20,
                              radius: 20,
                              showTitle: false,
                              color: ColorUtils.kcMediumRed),
                        ],
                        sectionsSpace: 0,
                        startDegreeOffset: 0,
                        centerSpaceRadius: 50),
                    swapAnimationDuration: const Duration(milliseconds: 1000),
                  ),
                ),
                Text(
                  '130',
                  style: FontStyleUtilities.h2(
                      context: context,
                      fontColor: ColorUtils.kcPrimary,
                      fontWeight: FWT.bold),
                )
              ],
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}

class StatData extends StatelessWidget {
  const StatData(
      {Key? key, required this.percent, required this.color, required this.tag})
      : super(key: key);
  final double percent;
  final Color color;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$percent%',
          style: FontStyleUtilities.h3(
            context: context,
            fontWeight: FWT.bold,
          ),
        ),
        Row(
          children: [
            Container(
              height: 9,
              width: 9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.5), color: color),
            ),
            5.0.width(),
            Text(
              tag,
              style: FontStyleUtilities.t2(
                  context: context, fontWeight: FWT.semiBold),
            )
          ],
        )
      ],
    );
  }
}
