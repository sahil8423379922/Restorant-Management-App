import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/api/service/api.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../db/DatabaseHelper.dart';

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

  Future<void> _fetchRestaurant(String userid) async {
    final restuantdata = await _restaurantService.fetchRestaurantData(userid);

    if (restuantdata != null) {
      var id = restuantdata.id!;

      setState(() {
        _fetchPendingOrder(id);
      });

      print(restuantdata.id);
    } else {
      setState(() {
        isLoading = false; // Stop loading if no restaurant data
      });
      print("No restaurant data received");
    }
  }

  Future<void> check_user_already_logged_in() async {
    List<Map<String, dynamic>> users = await DatabaseHelper.instance.getUsers();
    print('Data Received = $users');
    print(users[0]['userid']);

    setState(() {
      _fetchRestaurant(users[0]['userid']);
    });
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

        final obj = await {
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

  @override
  void initState() {
    super.initState();
    check_user_already_logged_in();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
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
                      child:
                          Text("No data available")) // Show message if no data
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
                                          "Name: " +
                                              dataArray[index]['customer_name'],
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
                                        onTap: () {},
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
    );
  }
}
