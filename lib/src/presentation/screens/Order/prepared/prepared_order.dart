import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/widgets/tagwidget.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:intl/intl.dart';

import '../../../../../db/ResturantDB.dart';
import '../../../../api/service/api.dart';

class PreparedOrder extends StatefulWidget {
  const PreparedOrder({Key? key}) : super(key: key);

  @override
  State<PreparedOrder> createState() => _PreparedOrderState();
}

class _PreparedOrderState extends State<PreparedOrder> {
  String formattedDate = "";
  String formattedTime = "";

  List<dynamic> dataArray = [];
  Map<String, dynamic> orderDetails = {};
  RestaurantService _restaurantService = RestaurantService();
  var restoid = "";
  bool isLoading = true; // Add this to track loading state

  Future<void> _fetchRestaurantData() async {
    List<Map<String, dynamic>> resturant =
        await ResturantHelper.instance.getDetails();
    print("Data Received from the DB 2 $resturant");

    if (resturant != null) {
      setState(() {
        var id = resturant[0]['resid'];
        _fetchPendingOrder(id);
      });
    } else {
      setState(() {
        isLoading = false; // Stop loading if no restaurant data
      });
      print("No restaurant data received");
    }
  }

  Future<void> _fetchPendingOrder(String id) async {
    final menuData = await _restaurantService.fetchPendingOrders(id);

    if (menuData != null) {
      print("Current response $menuData");

      final filteredData = menuData.where((order) {
        return order.length ==
            26; // Only keep objects with exactly 26 key-value pairs
      }).toList();

      var finalmenudetails = [];

      for (var orderdetails in filteredData) {
        final fetchorderdetails =
            await _restaurantService.fetchOrderDetails(orderdetails['code']);
        final fetchmenudetails = await _restaurantService
            .fetchMenuDetails(fetchorderdetails![0]['menu_id']);

        if (orderdetails['order_status'] == 'prepared') {
          print("order status received =" + orderdetails['order_status']);
          final obj = {
            'orderid': orderdetails['code'],
            'orderplacedat': orderdetails['order_placed_at'],
            'total_menu_price': orderdetails['total_menu_price'],
            'total_delivery_charge': orderdetails['total_delivery_charge'],
            'total_vat_amount': orderdetails['total_vat_amount'],
            'grand_total': orderdetails['grand_total'],
            'customer_name': orderdetails['customer_name'],
            'customer_email': orderdetails['customer_email'],
            'delivery_address': orderdetails['delivery_address'],
            'menuname': fetchmenudetails['name'],
            'restaurant_name': fetchmenudetails['restaurant_name'],
          };
          finalmenudetails.add(obj);
        }
      }

      setState(() {
        dataArray = finalmenudetails;
        isLoading = false; // Stop loading once data is fetched
        print("Final Menu Data = $finalmenudetails");
      });
    } else {
      setState(() {
        isLoading = false; // Stop loading if no data
      });
      print("No restaurant data received");
    }
  }

  void getCurrentDateTime() {
    // Get the current date and time
    DateTime now = DateTime.now();

    // If you want to format the date and time, use the intl package

    setState(() {
      formattedDate =
          DateFormat('EEEE, MMMM dd, yyyy').format(now); // e.g., 2024-10-03
      formattedTime = DateFormat('HH:mm').format(now); // e.g., 14:35:59
    });

    print("Current Date: $formattedDate");
    print("Current Time: $formattedTime");
  }

  @override
  void initState() {
    super.initState();
    _fetchRestaurantData();
    getCurrentDateTime();
  }

    Future<bool> _onWillPop(oid, phase) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want move order to Preparation?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () async => {await _approveOrder(oid, phase)},
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

   Future<void> _approveOrder(oid, phase) async {
    final fetchOrderDetails =
        await _restaurantService.ChangeOrderStatus(oid, phase);
    print("Order Status Updated");
    if (fetchOrderDetails != null) {
      setState(() {
        isLoading = true;
        _fetchRestaurantData();
        Navigator.of(context).pop(false);
      });
    } else {
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () => _onWillPop("oid", "phase"),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              itemCount: dataArray.length,
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
                              Text(
                                  'Customer Name: ' +
                                      dataArray[index]['customer_name'],
                                  style: FontStyleUtilities.t2(
                                      context: context, fontWeight: FWT.bold)),
                              Text('Email: ' + dataArray[index]['customer_email'],
                                  style: FontStyleUtilities.t4(
                                      context: context,
                                      fontWeight: FWT.semiBold)),
                              SpaceUtils.ks24.height(),
                              Text(
                                dataArray[index]['menuname'],
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                          Text(
                            '\$' + dataArray[index]['grand_total'],
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
                          height: 250,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: TrackerWidget(status: 3),
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
                                        titel: "Pending Order",
                                        sutite: "Order Approved Sucessfully"),
                                    TrackerWidgetText(
                                        titel: "Approved Order",
                                        sutite: "Order is under Preparation"),
                                    TrackerWidgetText(
                                        titel: "Order Preparing",
                                        sutite: "Order is under Preparation"),
                                    TrackerWidgetText(
                                        titel: "Order Prepared",
                                        sutite: "Order Preparation is Done"),
                                    TrackerWidgetText(
                                        titel: "Order Completed",
                                        sutite: "Order Completed Sucessfully"),
                                  ],
                                ),
                              )
                            ],
                          )),
                      SpaceUtils.ks30.height(),
                      Text(formattedDate,
                          style: FontStyleUtilities.t2(
                              context: context, fontWeight: FWT.bold)),
                      SpaceUtils.ks7.height(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formattedTime,
                            style: FontStyleUtilities.h3(
                                context: context, fontWeight: FWT.semiBold),
                          ),
                          SpaceUtils.ks16.width(),
                          const TagWidget(tagName: TagName.INPROGRESS),
                          const Spacer(),
                        ],
                      ),
                       SizedBox(height: 20,),
                                     Card(
                                      color: Colors.green,
                                       child: TextButton(
                                              onPressed: () {
                                                  _onWillPop(
                                                      dataArray[index]['orderid'],
                                                      "delivered");
                                              },
                                              child: SizedBox(
                                                
                                                height: 20,
                                                width: double.infinity,
                                                child: Text("Move to Preparation",textAlign: TextAlign.center,style: TextStyle(fontSize:20,color: Colors.white),),
                                              )),
                                     )
                    ],
                  ),
                );
              },
            ),
            SpaceUtils.ks120.height()
          ],
        ),
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
              NodeOfPercent(
                nodeNumber: 4,
                selctone: status >= 4,
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

   
//     var isDark = Theme.of(context).brightness == Brightness.dark;
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         children: [
//           ListView.builder(
//             itemCount: 3,
//             physics: const ClampingScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: isDark ? ColorUtils.kcSmoothBlack : ColorUtils.kcWhite,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                         offset: const Offset(-1, 7),
//                         blurRadius: 39,
//                         color: ColorUtils.kcTransparent.withOpacity(.13))
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                             child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Customer Name',
//                                 style: FontStyleUtilities.t1(
//                                     context: context, fontWeight: FWT.bold)),
//                             Text('+1 123456789',
//                                 style: FontStyleUtilities.t3(
//                                     context: context,
//                                     fontWeight: FWT.semiBold)),
//                             SpaceUtils.ks8.height(),
//                             ListView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: 3,
//                                 itemBuilder: (context, i) => Row(
//                                       children: [
//                                         Text(
//                                           '${index + i + 1} x ${items[i]} ',
//                                           style: FontStyleUtilities.t2(
//                                               context: context,
//                                               fontWeight: FWT.semiBold),
//                                         ),
//                                       ],
//                                     ))
//                           ],
//                         )),
//                         Text(
//                           '\$210.00',
//                           style: FontStyleUtilities.h5(
//                               context: context, fontWeight: FWT.bold),
//                         ),
//                       ],
//                     ),
//                     SpaceUtils.ks30.height(),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('COMPLETED ON',
//                                 style: FontStyleUtilities.t2(
//                                     context: context,
//                                     fontWeight: FWT.extrabold)),
//                             Text('June 2, 2021 at 7:00 PM',
//                                 style: FontStyleUtilities.t2(
//                                     context: context,
//                                     fontWeight: FWT.semiBold)),
//                             SpaceUtils.ks10.height(),
//                           ],
//                         ),
//                         const Spacer(),
//                         SvgPicture.asset(
//                           IconUtil.call,
//                           color: isDark
//                               ? ColorUtils.kcWhite
//                               : ColorUtils.kcCallIconColor,
//                         )
//                       ],
//                     ),
//                     Text('Rated',
//                         style: FontStyleUtilities.t1(
//                             context: context, fontWeight: FWT.bold)),
//                     SpaceUtils.ks7.height(),
//                     Row(
//                       children: [
//                         SvgPicture.asset(
//                           'asset/icons/happy.svg',
//                           height: 27,
//                           color: const Color(0xff08C25E),
//                         ),
//                         SpaceUtils.ks16.width(),
//                         Text('Satisfied',
//                             style: FontStyleUtilities.t1(
//                                 context: context, fontWeight: FWT.bold)),
//                         const Spacer(),
//                         const TagWidget(
//                           tagName: TagName.COMP,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//           SpaceUtils.ks120.height(),
//         ],
//       ),
//     );
//   }
// }

// List<String> items = [
//   ' Soya, Broccoli, Vegetables',
//   " Pepper Paneer",
//   ' Garlic Bread'
// ];
