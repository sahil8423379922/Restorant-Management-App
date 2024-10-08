import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/api/service/api.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../db/DatabaseHelper.dart';
import '../../../../../db/ResturantDB.dart';

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
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

        if (orderDetails['order_status'] == 'pending') {
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

  @override
  void initState() {
    super.initState();
    _fetchRestaurantData();
  }

  Future<bool> _onWillPop(oid, phase) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to Approve Order'),
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
                    child:
                        CircularProgressIndicator(), // Show progress indicator while loading
                  )
                : dataArray.isEmpty
                    ? Center(
                        child: Text(
                            "No data available")) // Show message if no data
                    : ListView.builder(
                        itemCount: dataArray.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final orderId = dataArray[index]['orderid'];
                          final details = orderDetails[orderId];

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
                                      ColorUtils.kcTransparent.withOpacity(.13),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataArray[index]['menuname'],
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SpaceUtils.ks8.height(),
                                          Text(
                                            "Name: " +
                                                dataArray[index]
                                                    ['customer_name'],
                                            style: FontStyleUtilities.t2(
                                              context: context,
                                              fontWeight: FWT.bold,
                                            ),
                                          ),
                                          Text(
                                            "Email: " +
                                                dataArray[index]
                                                    ['customer_email'],
                                            style: FontStyleUtilities.t4(
                                              context: context,
                                              fontWeight: FWT.semiBold,
                                            ),
                                          ),
                                          Text(
                                            "Address: " +
                                                dataArray[index]
                                                    ['delivery_address'],
                                            style: FontStyleUtilities.t4(
                                              context: context,
                                              fontWeight: FWT.semiBold,
                                            ),
                                          ),
                                          SpaceUtils.ks8.height(),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '\$${dataArray[index]['grand_total']}',
                                      style: FontStyleUtilities.h5(
                                        context: context,
                                        fontWeight: FWT.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SpaceUtils.ks30.height(),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Bill Details :"),
                                        Text(
                                          "Menu Price: " +
                                              dataArray[index]
                                                  ['total_menu_price'],
                                          style: FontStyleUtilities.t2(
                                            context: context,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          "Delivery Charges: " +
                                              dataArray[index]
                                                  ['total_delivery_charge'],
                                          style: FontStyleUtilities.t2(
                                            context: context,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          "Total VAT: " +
                                              dataArray[index]
                                                  ['total_vat_amount'],
                                          style: FontStyleUtilities.t2(
                                            context: context,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        Text(
                                          "Grand Total: " +
                                              dataArray[index]['grand_total'],
                                          style: FontStyleUtilities.t2(
                                            context: context,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        SpaceUtils.ks30.height(),
                                        Text("Order Placed At :"),
                                        Text(
                                          dataArray[index]['orderplacedat'],
                                          style: FontStyleUtilities.t2(
                                            context: context,
                                            fontWeight: FWT.bold,
                                          ),
                                        ),
                                        SpaceUtils.ks16.height(),
                                        Text("Order ID",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                          orderId,
                                          style: TextStyle(
                                              backgroundColor: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                SpaceUtils.ks18.height(),
                                SizedBox(
                                  child: Row(
                                    children: [
                                      SpaceUtils.ks18.width(),
                                      Expanded(
                                        child: MasterButton(
                                          radius: 25,
                                          tittle: 'Approved',
                                          color: ColorUtils.kcGreenColor,
                                          onTap: () {
                                            _onWillPop(
                                                dataArray[index]['orderid'],
                                                "approved");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
