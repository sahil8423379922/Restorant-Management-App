import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/screens/Order/active/active.dart';
import 'package:resturant_side/src/presentation/screens/Order/complete/complete.dart';
import 'package:resturant_side/src/presentation/screens/Order/delivered/delivered_order.dart';
import 'package:resturant_side/src/presentation/screens/Order/new/new.dart';
import 'package:resturant_side/src/presentation/screens/Order/prepared/prepared_order.dart';
import 'package:resturant_side/src/presentation/screens/Settings/settings.dart';
import 'package:resturant_side/src/presentation/screens/notification/notification.dart';
import 'package:resturant_side/src/presentation/screens/resturanttable/freetable/freetable.dart';
import 'package:resturant_side/src/presentation/widgets/customiconbutton.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class OrderMain extends StatefulWidget {
  const OrderMain({
    Key? key,
    required this.indexer,
    required this.stringify,
    required this.tabTIme,
    required this.tap,
  }) : super(key: key);
  final Indexer indexer;
  final Stringify stringify, tabTIme;
  final VoidCallback tap;

  @override
  State<OrderMain> createState() => _OrderMainState();
}

class _OrderMainState extends State<OrderMain>
    with SingleTickerProviderStateMixin {
  late TabController _OrderMainController;
  late List<GlobalKey> tabKeys;

  @override
  void initState() {
    super.initState();
    _OrderMainController = TabController(length: 5, vsync: this);
    tabKeys = List.generate(5, (_) => GlobalKey());
  }

  @override
  void dispose() {
    _OrderMainController.dispose();
    super.dispose();
  }

  List<String> tabs = <String>[
    'Pending Order',
    'Approved Order',
    'Preparing Order',
    'Prepared Order',
    'Delivered Order'
  ];
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
      appBar: AppBar(
        title: Text(
          'Orders',
          style: FontStyleUtilities.h4(context: context, fontWeight: FWT.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
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
            navigateToPage(context, page: SettingsPage());
          },
          child: SvgPicture.asset(
            IconUtil.menu,
            height: 20,
            color: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    ColorUtils.kcTransparent.withOpacity(.018),
                    ColorUtils.kcTransparent.withOpacity(.008),
                  ])),
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              height: 80,
              child: TabBar(
                onTap: (int index) {
                  selextedTab = index;

                  widget.tabTIme(times[index]);
                  setState(() {});
                },
                indicatorPadding: const EdgeInsets.only(top: 10),
                indicatorWeight: 2.5,
                // indicatorSize: TabBarIndicatorSize.label,
                labelColor: ColorUtils.kcPrimary,
                unselectedLabelColor:
                    isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
                isScrollable: true,
                controller: _OrderMainController,
                tabs: tabs
                    .map((e) => SizedBox(
                          child: Column(
                            children: [
                              // Text(
                              //   "${e.length + 1}",
                              //   style: const TextStyle(
                              //     fontFamily: 'Sands',
                              //     fontSize: 28,
                              //     fontWeight: FontWeight.w700,
                              //   ),
                              // ),
                              Text(
                                e,
                                style: const TextStyle(
                                  fontFamily: 'Sands',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              )),
          Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _OrderMainController,
                  children: [
                KeyedSubtree(key: tabKeys[0], child: const New()),
                KeyedSubtree(key: tabKeys[1], child: const Active()),
                KeyedSubtree(key: tabKeys[2], child: const Complete()),
                KeyedSubtree(key: tabKeys[3], child: const PreparedOrder()),
                KeyedSubtree(key: tabKeys[4], child: const DeliverdOrder()),
              ])),
        ],
      ),
    );
  }
}
