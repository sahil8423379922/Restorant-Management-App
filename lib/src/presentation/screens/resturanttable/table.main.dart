import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/Settings/settings.dart';
import 'package:resturant_side/src/presentation/screens/notification/notification.dart';
import 'package:resturant_side/src/presentation/screens/resturanttable/occupied/ocupied.dart';
import 'package:resturant_side/src/presentation/screens/resturanttable/reserved/reserved.dart';
import 'package:resturant_side/src/presentation/widgets/customiconbutton.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

import '../../../theme/app_theme.dart';
import 'freetable/freetable.dart';

class TableMain extends StatefulWidget {
  const TableMain({
    Key? key,
    required this.indexer,
    required this.stringify,
    required this.tabTIme,
    required this.tap,
    required this.restaurantName,
    required this.aboutrestro,
    required this.address,
    required this.thumbnail,
  }) : super(key: key);
  final Indexer indexer;
  final Stringify stringify, tabTIme;
  final VoidCallback tap;
  final String restaurantName;
  final String aboutrestro;
  final String address;
  final List<String> thumbnail;

  @override
  State<TableMain> createState() => _TableMainState();
}

class _TableMainState extends State<TableMain>
    with SingleTickerProviderStateMixin {
  late TabController _TableMainController;
  @override
  void initState() {
    _TableMainController = TabController(length: 3, vsync: this);
    super.initState();
  }

  List<String> tabs = <String>['Current Order', 'Today Order', 'All Order'];
  List<String> times = <String>[
    '4',
    '3',
    '9',
    '2',
    '11',
    '6',
    '11',
    '13',
    '15'
  ];

  int selectedtime = 0;
  int selextedTab = 0;

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // backgroundColor: ColorUtils.kcWhite,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: FontStyleUtilities.h4(fontWeight: FWT.bold, context: context),
        ),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: ColorUtils.kcWhite,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: isDark
                  ? ColorUtils.kcIconBackgroundColor
                  : ColorUtils.kcTableNumberColor,
              child: AnimatedSwitcher(
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 1000),
                  child: isDark
                      ? IconButton(
                          onPressed: () {
                            final provider = Provider.of<ThemeProvider>(context,
                                listen: false);
                            provider.toggleTheme(false);
                          },
                          icon: const Icon(Icons.sunny))
                      : IconButton(
                          onPressed: () {
                            final provider = Provider.of<ThemeProvider>(context,
                                listen: false);
                            provider.toggleTheme(true);
                          },
                          icon: const Icon(Icons.mode_night,
                              color: ColorUtils.kcBlueButton))),
            ),
          ),
          CustomIconButton(
              onTap: () {
                navigateToPage(context, page: const NotificationPage());
              },
              child: SvgPicture.asset(
                isDark ? IconUtil.darkBell : IconUtil.bell,
              )),
          SpaceUtils.ks20.width(),
        ],

        leading: CustomIconButton(
          size: 20,
          onTap: () {
            navigateToPage(context,
                page: SettingsPage(
                ));
          },
          child: SvgPicture.asset(
            IconUtil.menu,
            height: 20,
            color: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SpaceUtils.ks7.height(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 27, right: 24, bottom: 23),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceUtils.ks10.height(),
                        Text(
                          'Total (Buy Now)',
                          style: FontStyleUtilities.t3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        Text(
                          'Order Placed',
                          style: FontStyleUtilities.h4(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks7.height(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 27, right: 24, bottom: 23),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceUtils.ks10.height(),
                        Text(
                          'Total (Buy Now)',
                          style: FontStyleUtilities.t3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        Text(
                          'Order Processed',
                          style: FontStyleUtilities.h4(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks7.height(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 27, right: 24, bottom: 23),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceUtils.ks10.height(),
                        Text(
                          'Total (Buy Now)',
                          style: FontStyleUtilities.t3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        Text(
                          'Order Delivered',
                          style: FontStyleUtilities.h4(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks7.height(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 27, right: 24, bottom: 23),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceUtils.ks10.height(),
                        Text(
                          'Total (Buy Now)',
                          style: FontStyleUtilities.t3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        Text(
                          'Order Cancelled',
                          style: FontStyleUtilities.h4(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks7.height(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 27, right: 24, bottom: 23),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceUtils.ks10.height(),
                        Text(
                          'Approved',
                          style: FontStyleUtilities.t3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        Text(
                          'Restaurant',
                          style: FontStyleUtilities.h4(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks7.height(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 27, right: 24, bottom: 23),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceUtils.ks10.height(),
                        Text(
                          'Saved',
                          style: FontStyleUtilities.t3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        Text(
                          'Active Customers',
                          style: FontStyleUtilities.h4(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks7.height(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 22),
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 27, right: 24, bottom: 23),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpaceUtils.ks10.height(),
                        Text(
                          'Saved',
                          style: FontStyleUtilities.t3(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        Text(
                          'Delivery Person',
                          style: FontStyleUtilities.h4(
                              context: context, fontWeight: FWT.semiBold),
                        ),
                        SpaceUtils.ks7.height(),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                ],
              ),
            ),

            // Container(
            //   decoration: BoxDecoration(
            //     color: isDark ? ColorUtils.kcbackDarkColor : ColorUtils.kcWhite,
            //     borderRadius: BorderRadius.circular(4),
            //   ),
            //   child: SizedBox(
            //     height: 100,
            //     width: double.infinity,
            //     child: Row(children: [
            //       Expanded(flex: 4, child: Container()),
            //       Expanded(
            //           flex: 8,
            //           child: Column(
            //             children: [
            //               Text("Total(Buy Now)"),
            //               Text("Order Placed"),
            //               Text("0")
            //             ],
            //           ))
            //     ]),
            //   ),
            // )

            // Container(
            //     padding: const EdgeInsets.only(top: 24, bottom: 12),
            //     decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //             begin: Alignment.bottomCenter,
            //             end: Alignment.topCenter,
            //             colors: [
            //           ColorUtils.kcTransparent.withOpacity(.018),
            //           ColorUtils.kcTransparent.withOpacity(.008),
            //         ])),
            //     height: 100,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 37),
            //       child: TabBar(
            //         onTap: (int index) {
            //           selextedTab = index;

            //           widget.tabTIme(times[index]);
            //           setState(() {});
            //         },
            //         indicatorPadding: const EdgeInsets.only(top: 10),
            //         indicatorWeight: 2.5,
            //         indicatorSize: TabBarIndicatorSize.label,
            //         labelColor: ColorUtils.kcPrimary,
            //         unselectedLabelColor:
            //             isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
            //         isScrollable: true,
            //         controller: _TableMainController,
            //         tabs: tabs
            //             .map((e) => SizedBox(
            //                   child: Column(
            //                     children: [
            //                       Text(
            //                         "${e.length + 1}",
            //                         style: const TextStyle(
            //                           fontFamily: 'Sands',
            //                           fontSize: 28,
            //                           fontWeight: FontWeight.w700,
            //                         ),
            //                       ),
            //                       Text(
            //                         e,
            //                         style: const TextStyle(
            //                           fontFamily: 'Sands',
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ))
            //             .toList(),
            //       ),
            //     )),

            // Expanded(
            //     child: TabBarView(
            //         physics: const NeverScrollableScrollPhysics(),
            //         controller: _TableMainController,
            //         children: [
            //       const Occupied(),
            //       FreeTable(
            //           tap: widget.tap, times: times, stringify: widget.stringify),
            //       const Reserved(),
            //     ])),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
