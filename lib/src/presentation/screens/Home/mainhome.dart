import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:resturant_side/src/custompackge/curvednavbar/maincurved.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/Customer/customer.dart';
import 'package:resturant_side/src/presentation/screens/Order/order.main.dart';
import 'package:resturant_side/src/presentation/screens/dialog/dialog.dart';

import 'package:resturant_side/src/presentation/screens/items/Itemstoshow/itemscreen.dart';
import 'package:resturant_side/src/presentation/screens/resturanttable/table.main.dart';
import 'package:resturant_side/src/presentation/screens/stats/stats.dart';
import 'package:resturant_side/src/utils/iconutil.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(
      vsync: this,
      length: 5,
    );
    super.initState();
  }

  onTap(int i) {
    selectedIndex = i;
    _controller.animateTo(i,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    // setState(() {});
  }

  List<String> names = ['Table', 'Items', 'Order', 'Users', 'Stats'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        var v = await showDialog<bool?>(
            context: context,
            builder: (context) => Dialog(
                  backgroundColor: ColorUtils.kcTransparent,
                  child: CommonDialog(
                      tittle: 'Are you sure?',
                      subTittle: 'On tap Quit application will closed',
                      buttonText: 'Quit',
                      dialogThemeColor: ColorUtils.kcPrimary,
                      avatarChild: const Icon(Icons.close),
                      onTap: () {
                        Navigator.pop(context, true);
                      }),
                ));
        return v ?? false;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                // index: selectedIndex,
                controller: _controller,
                children: [
                  TableMain(
                      indexer: (i) {},
                      stringify: (i) {},
                      tabTIme: (i) {},
                      tap: () {}),
                  const ItemScreen(),
                  OrderMain(
                      indexer: (i) {},
                      stringify: (i) {},
                      tabTIme: (i) {},
                      tap: () {}),
                  const Customers(),
                  const Stats()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: SizedBox(
                width: size.width,
                child: CurvedNavigationBar(
                    letIndexChange: (i) {
                      return true;
                    },
                    onTap: (i) {
                      onTap(i);
                    },
                    index: selectedIndex,
                    color: ColorUtils.kcPrimary,
                    buttonBackgroundColor: ColorUtils.kcPrimary,
                    animationDuration: const Duration(milliseconds: 450),
                    backgroundColor: Colors.transparent,
                    height: 69,
                    items: [
                      SvgPicture.asset(
                        IconUtil.table,
                        color: ColorUtils.kcWhite,
                      ),
                      SvgPicture.asset(
                        IconUtil.items,
                        color: ColorUtils.kcWhite,
                      ),
                      SvgPicture.asset(
                        IconUtil.order,
                        color: ColorUtils.kcWhite,
                      ),
                      SvgPicture.asset(
                        IconUtil.customer,
                        color: ColorUtils.kcWhite,
                      ),
                      SvgPicture.asset(
                        IconUtil.stats,
                        color: ColorUtils.kcWhite,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tables',
                    style: FontStyleUtilities.t3(
                        context: context,
                        fontWeight: FWT.semiBold,
                        fontColor: ColorUtils.kcWhite),
                  ),
                  Text(
                    'Items',
                    style: FontStyleUtilities.t3(
                        context: context,
                        fontWeight: FWT.semiBold,
                        fontColor: ColorUtils.kcWhite),
                  ),
                  Text(
                    'Order',
                    style: FontStyleUtilities.t3(
                        context: context,
                        fontWeight: FWT.semiBold,
                        fontColor: ColorUtils.kcWhite),
                  ),
                  Text(
                    'Customers',
                    style: FontStyleUtilities.t3(
                        context: context,
                        fontWeight: FWT.semiBold,
                        fontColor: ColorUtils.kcWhite),
                  ),
                  Text(
                    'Stats',
                    style: FontStyleUtilities.t3(
                        context: context,
                        fontWeight: FWT.semiBold,
                        fontColor: ColorUtils.kcWhite),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
