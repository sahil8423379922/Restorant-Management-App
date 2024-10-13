import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

import '../../../../../db/ResturantDB.dart';
import '../../../../api/service/api.dart';
import 'package:intl/intl.dart';

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
    _fetchRestaurantData() ;
  }

  RestaurantService _restaurantService = RestaurantService();
  List<double> dataY = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int maxy=0;
  int totalamt =0;

  Future<void> _fetchRestaurantData() async {
    List<Map<String, dynamic>> resturant =
        await ResturantHelper.instance.getDetails();
    print("Data Received from the DB 2 $resturant");

    if (resturant != null) {
      setState(() {
        var id = resturant[0]['resid'];
        fetchownerpay(id);
       
      });
    } else {
      print("No restaurant data received");
    }
  }

  Future<void> fetchownerpay(id) async {
    final pay = await _restaurantService.fetchownerpay(id);
    print("Information about the owner pay");
    print(pay);
    List<dynamic> formattedOrders = pay.map((order) {
    DateTime dateAdded = DateTime.fromMillisecondsSinceEpoch(int.parse(order['date_added']) * 1000);
    String formattedDate = "${dateAdded.year}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')} ${dateAdded.hour.toString().padLeft(2, '0')}:${dateAdded.minute.toString().padLeft(2, '0')}:${dateAdded.second.toString().padLeft(2, '0')}";
    formattedDate = DateFormat('dd-MM-yy').format(dateAdded);
    return {
      'id': order['id'],
      'order_code': order['order_code'],
      'total_bill': order['total_bill'],
      'admin_commission': order['admin_commission'],
      'owner_commission': order['owner_commission'],
      'date_added': formattedDate,
      'restaurant_id': order['restaurant_id'],
    };
  }).toList();

  // Print formatted orders
  formattedOrders.forEach((order) {
  int ownerCommission =int.parse( order['owner_commission']);
  String dateAdded = order['date_added'];
  int month = DateFormat('dd-MM-yy').parse(dateAdded).month;
  setState(() {
    totalamt =totalamt +ownerCommission;
    dataY[month - 1] =dataY[month - 1]+ ownerCommission.toDouble();
  });
  print("Value of month received ="+month.toString());
  print(dateAdded);
  print(dataY);

  
  
  });

  dataY.forEach((element) {
    
    int c = element.toInt();

    if(maxy<c){
      setState(() {
        maxy=c;
      });
      
    }


  });

  print("Maximum range of y is "+maxy.toString());



  }

  
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
                    maxY: maxy.toDouble(),
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
            "CAD "+totalamt.toString(),
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
