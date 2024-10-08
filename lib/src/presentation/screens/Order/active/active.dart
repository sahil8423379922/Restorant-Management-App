import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/tagwidget.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:intl/intl.dart';

import '../../../../../db/ResturantDB.dart';
import '../../../../api/service/api.dart';
import '../../../widgets/masterbutton.dart';

class Active extends StatefulWidget {
  const Active({Key? key}) : super(key: key);

  @override
  _ActiveState createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
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

      var finalMenuDetails =
          await Future.wait(filteredData.map((orderDetails) async {
        final fetchOrderDetails =
            await _restaurantService.fetchOrderDetails(orderDetails['code']);
        final fetchMenuDetails = await _restaurantService
            .fetchMenuDetails(fetchOrderDetails![0]['menu_id']);

        if (orderDetails['order_status'] == 'approved') {
          print("order status received =" + orderDetails['order_status']);
          return {
            'orderid': orderDetails['code'],
            'orderplacedat': orderDetails['order_placed_at'],
            'total_menu_price': orderDetails['total_menu_price'],
            'total_delivery_charge': orderDetails['total_delivery_charge'],
            'total_vat_amount': orderDetails['total_vat_amount'],
            'grand_total': orderDetails['grand_total'],
            'customer_name': orderDetails['customer_name'],
            'customer_email': orderDetails['customer_email'],
            'delivery_address': orderDetails['delivery_address'],
            'menuname': fetchMenuDetails['name'],
            'restaurant_name': fetchMenuDetails['restaurant_name'],
          };
        }
        return null;
      }).toList());

      // Remove any null entries from the final data
      finalMenuDetails = finalMenuDetails.where((e) => e != null).toList();

      if (mounted) {
        setState(() {
          dataArray = finalMenuDetails;
          isLoading = false;
          print("Final Menu Details");
        });
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
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
            isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : dataArray.isEmpty
                    ? Center(
                        child: Text('No Data Available'),
                      )
                    : ListView.builder(
                        itemCount: dataArray.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? ColorUtils.kcSmoothBlack
                                  : ColorUtils.kcWhite,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(-1, 7),
                                    blurRadius: 39,
                                    color:
                                        ColorUtils.kcTransparent.withOpacity(.13))
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Customer Name: ' +
                                                dataArray[index]['customer_name'],
                                            style: FontStyleUtilities.t2(
                                                context: context,
                                                fontWeight: FWT.bold)),
                                        Text(
                                            'Email: ' +
                                                dataArray[index]
                                                    ['customer_email'],
                                            style: FontStyleUtilities.t4(
                                                context: context,
                                                fontWeight: FWT.semiBold)),
                                        SpaceUtils.ks24.height(),
                                        Text(
                                          dataArray[index]['menuname'],
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
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
                                        context: context,
                                        fontWeight: FWT.semiBold)),
                                SpaceUtils.ks10.height(),
                                SizedBox(
                                    height: 250,
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: TrackerWidget(status: 1),
                                        ),
                                        SpaceUtils.ks16.width(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              TrackerWidgetText(
                                                  titel: "Pending Order",
                                                  sutite:
                                                      "Order Approved Sucessfully"),
                                              TrackerWidgetText(
                                                  titel: "Approved Order",
                                                  sutite:
                                                      "Order is under Preparation"),
                                              TrackerWidgetText(
                                                  titel: "Order Preparing",
                                                  sutite:
                                                      "Order is under Preparation"),
                                              TrackerWidgetText(
                                                  titel: "Order Prepared",
                                                  sutite:
                                                      "Order Preparation is Done"),
                                              TrackerWidgetText(
                                                  titel: "Order Completed",
                                                  sutite:
                                                      "Order Completed Sucessfully"),
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
                                          context: context,
                                          fontWeight: FWT.semiBold),
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
                                                  "preparation");
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
            SpaceUtils.ks120.height(),
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
