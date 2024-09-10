import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

class MyBarChartData extends StatefulWidget {
  const MyBarChartData({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBarChartData> createState() => _MyBarChartDataState();
}

class _MyBarChartDataState extends State<MyBarChartData>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _controller.forward();
    super.initState();
  }

  List<double> dataY = [6, 7, 5, 4, 9, 11, 8, 5, .75, .75, .75, .75];
  List<String> names = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return CommonShadowContainer(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 15, bottom: 10),
      height: 200,
      padding: const EdgeInsets.only(top: 12, bottom: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => BarChart(
                BarChartData(
                    titlesData: FlTitlesData(
                      bottomTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    maxY: 15,
                    minY: 0,
                    barGroups: [
                      ...dataY
                          .map(
                            (e) => BarChartGroupData(
                                barsSpace: 10,
                                x: 15,
                                barRods: [
                                  BarChartRodData(
                                    color: ColorUtils.kcPrimary,
                                    width: 18,
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(5)),
                                    toY: e.toDouble() * _controller.value,
                                  )
                                ]),
                          )
                          .toList(),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...names
                    .map((e) => Text(
                          e,
                          style: FontStyleUtilities.t5(
                              context: context,
                              fontWeight: FWT.semiBold,
                              fontColor: isDark
                                  ? ColorUtils.kcWhite
                                  : ColorUtils.kcBlueButton.withOpacity(.70)),
                        ))
                    .toList()
              ],
            ),
          ),
          SpaceUtils.ks10.height(),
          Text(
            'Revenue',
            style: FontStyleUtilities.h4(
                fontWeight: FWT.bold,
                fontColor:  isDark
                                  ? ColorUtils.kcWhite
                                  : ColorUtils.kcBlueButton.withOpacity(1),
                context: context),
          ),
          Text(
            'INR 35000',
            style: FontStyleUtilities.h2(
                context: context,
                fontWeight: FWT.bold,
                fontColor: ColorUtils.kcPrimary),
          ),
        ],
      ),
    );
  }
}
