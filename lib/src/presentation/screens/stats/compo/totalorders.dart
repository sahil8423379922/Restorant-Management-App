import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

import '../../../../../db/ResturantDB.dart';
import '../../../../api/service/api.dart';

class TotalOrders extends StatefulWidget {
  const TotalOrders({
    Key? key,
  }) : super(key: key);

  @override
  State<TotalOrders> createState() => _TotalOrdersState();
}

class _TotalOrdersState extends State<TotalOrders> {
  RestaurantService _restaurantService = RestaurantService();
  
  var totalorderplaced = 0;
  var totaldeliveredorder = 0;

  

  Future<void> _fetchRestaurantData() async {
    List<Map<String, dynamic>> resturant =
        await ResturantHelper.instance.getDetails();
    print("Data Received from the DB 2 $resturant");

    if (resturant != null) {
      setState(() {
        var id = resturant[0]['resid'];
        _fetchTotalOrder(id);
        _fetchDeliveredOrder(id);
      });
    } else {
      print("No restaurant data received");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchRestaurantData();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return CommonShadowContainer(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Orders',
                  style: FontStyleUtilities.h5(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: isDark
                          ? ColorUtils.kcWhite
                          : ColorUtils.kcBlueButton.withOpacity(1)),
                ),
                Text(
                  totalorderplaced.toString(),
                  style: FontStyleUtilities.h2(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: ColorUtils.kcPrimary),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Delivered',
                  style: FontStyleUtilities.h5(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: isDark
                          ? ColorUtils.kcWhite
                          : ColorUtils.kcBlueButton.withOpacity(1)),
                ),
                Text(
                  totaldeliveredorder.toString(),
                  style: FontStyleUtilities.h2(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: ColorUtils.kcPrimary),
                ),
              ],
            ),
            const Spacer(),
          ],
        ));
  }

  Future<void> _fetchTotalOrder(id) async {

    final menuData = await _restaurantService.fetchtotalOrder(id);

    setState(() {
      totalorderplaced =menuData.length;
    });
    print(menuData.length);
  }

   //fetchdeliveredOrder
  Future<void> _fetchDeliveredOrder(id) async {
    final menuData = await _restaurantService.fetchdeliveredOrder(id);
    final filteredData = menuData.where((order) {
        return order.length ==
            26; // Only keep objects with exactly 26 key-value pairs
      }).toList();

    setState(() {
      totaldeliveredorder =filteredData.length;
    });
    print(menuData.length);

  }
}
