import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

class Top5 extends StatefulWidget {
  const Top5({
    Key? key,
  }) : super(key: key);

  @override
  State<Top5> createState() => _Top5State();
}

class _Top5State extends State<Top5> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  int selectedIndex = 0;
  onTap(int index) {
    selectedIndex = index;
    setState(() {});
  }

  List<String> dishes = <String>[
    'FarmHouse Pizza',
    'Macaroni',
    'Burger',
    'Hot Chilli',
    'Red Dish'
  ];
  List<String> customers = <String>[
    'John Alberto',
    'Ronaldo',
    'Bill Gets',
    'Mickle Jackson',
    'Elon Musk'
  ];

  @override
  Widget build(BuildContext context) {
     var isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox();
    // CommonShadowContainer(
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    //     margin: const EdgeInsets.only(
    //       left: 24,
    //       right: 24,
    //       top: 0,
    //     ),
    //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //       Text(
    //         'Top 5',
    //         style: FontStyleUtilities.t1(context: context,
    //           fontWeight: FWT.bold,
    //         ),
    //       ),
    //       SpaceUtils.ks10.height(),
    //       TabBar(
    //         onTap: (index) {
    //           onTap(index);
    //         },
    //         indicatorWeight: 3,
    //         labelStyle: const TextStyle(
    //           fontFamily: 'Sands',
    //           fontWeight: FontWeight.w600,
    //           fontSize: 13,
    //         ),
    //         unselectedLabelStyle: const TextStyle(
    //           fontFamily: 'Sands',
    //           fontWeight: FontWeight.w600,
    //           fontSize: 13,
    //         ),
    //         unselectedLabelColor:  isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
    //         labelPadding: const EdgeInsets.only(bottom: 10),
    //         labelColor: ColorUtils.kcPrimary,
    //         tabs: const [
    //           Tab(
    //             iconMargin: EdgeInsets.zero,
    //             height: 20,
    //             text: 'Top 5 Dishes',
    //           ),
    //           Tab(
    //               iconMargin: EdgeInsets.zero,
    //               height: 20,
    //               text: "Top 5 Customers")
    //         ],
    //         controller: _tabController,
    //       ),
    //       SpaceUtils.ks16.height(),
    //       selectedIndex == 0
    //           ? ListView.builder(
    //               physics: const NeverScrollableScrollPhysics(),
    //               itemBuilder: (context, i) => TopText(
    //                 dishes: dishes,
    //                 index: i,
    //               ),
    //               itemCount: dishes.length,
    //               shrinkWrap: true,
    //             )
    //           : ListView.builder(
    //               physics: const NeverScrollableScrollPhysics(),
    //               itemBuilder: (context, i) => TopText(
    //                 dishes: customers,
    //                 index: i,
    //               ),
    //               itemCount: customers.length,
    //               shrinkWrap: true,
    //             )
    //     ]));
 
 
  }
}

class TopText extends StatelessWidget {
  const TopText({
    Key? key,
    required this.dishes,
    required this.index,
  }) : super(key: key);

  final List<String> dishes;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Container(
            height: 13,
            width: 13,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5),
                color: ColorUtils.kcLightRed),
          ),
          SpaceUtils.ks10.width(),
          Text(dishes[index],
              style: FontStyleUtilities.t2(context: context,fontWeight: FWT.semiBold)),
          SpaceUtils.ks10.width(),
          Container(
            padding: const EdgeInsets.all(0),
            height: 14,
            width: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorUtils.kcBlueButton.withOpacity(.50),
            ),
            child: Center(
                child: Text(
              '${index + 1 * 7}',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: ColorUtils.kcWhite,
                  fontFamily: 'Sands'),
            )),
          ),
        ],
      ),
    );
  }
}
