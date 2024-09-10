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
  }) : super(key: key);
  final Indexer indexer;
  final Stringify stringify, tabTIme;
  final VoidCallback tap;

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

  List<String> tabs = <String>['Occupied', 'Free', 'Reserved '];
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
          'Tables',
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
            navigateToPage(context, page: const SettingsPage());
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
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    ColorUtils.kcTransparent.withOpacity(.018),
                    ColorUtils.kcTransparent.withOpacity(.008),
                  ])),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: TabBar(
                  onTap: (int index) {
                    selextedTab = index;

                    widget.tabTIme(times[index]);
                    setState(() {});
                  },
                  indicatorPadding: const EdgeInsets.only(top: 10),
                  indicatorWeight: 2.5,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: ColorUtils.kcPrimary,
                  unselectedLabelColor:
                      isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
                  isScrollable: true,
                  controller: _TableMainController,
                  tabs: tabs
                      .map((e) => SizedBox(
                            child: Column(
                              children: [
                                Text(
                                  "${e.length + 1}",
                                  style: const TextStyle(
                                    fontFamily: 'Sands',
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  e,
                                  style: const TextStyle(
                                    fontFamily: 'Sands',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              )),
          Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _TableMainController,
                  children: [
                const Occupied(),
                FreeTable(
                    tap: widget.tap, times: times, stringify: widget.stringify),
                const Reserved(),
              ])),
        ],
      ),
    );
  }
}
