import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resturant_side/src/model/items/resturant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/db/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'package:resturant_side/src/custompackge/curvednavbar/maincurved.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/Customer/customer.dart';
import 'package:resturant_side/src/presentation/screens/Order/order.main.dart';
import 'package:resturant_side/src/presentation/screens/ResturantSettingPage/resturantsettingpage.dart';
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
  String resturantname = "";
  String aboutus = "";
  String address = "";
  List<String> thumbnail = [];
  int selectedIndex = 0;

  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(
      vsync: this,
      length: 5,
    );
    fetchrestro('34');
    super.initState();
  }

  Future<void> fetchrestro(String id) async {
    const String apiUri = "https://www.guildresto.com/api/restaurant";

    // API payload
    final Map<String, dynamic> requestBody = {
      "id": "34",
    };

    // Log received values
    print("Received ID: $id");

    // Log the request body
    print("Request Payload: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        Uri.parse(apiUri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Response Data: $responseData");

        if (responseData.length > 1) {
          parseData(responseData);
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (error) {
      print("Error during API call: $error");
    }
  }

  void parseData(Map<String, dynamic> responseData) {
    print("Parse Data Function is called");

    Restaurant resturant = Restaurant.fromJson(responseData);
    print('ID =${resturant.id}');
    setState(() {
      resturantname = resturant.name!;
      aboutus = resturant.aboutUs!;
      address = resturant.address!;
      thumbnail = resturant.thumbnail!;
    });
    print('Name =${resturant.name}');
    print('About =${resturant.aboutUs}');
    print('Cusine =${resturant.cuisine}');
    print('Address =${resturant.address}');
    print('Phone =${resturant.phone}');
    print('Schedule =${resturant.schedule}');
    print('Owner ID =${resturant.ownerId}');
    print('Owner Email =${resturant.ownerEmail}');
    print('Owner phone =${resturant.ownerPhone}');
    print('Schedule =${resturant.schedule}');
    print('Thumbnail  =${resturant.thumbnail}');
    print('ResturantThumbnail  =${resturant.restaurantThumbnail}');
    print('AboutusThumbnail  =${resturant.aboutUsThumbnail}');
    print('Delivery Charge  =${resturant.deliveryCharge}');
    print('Maximum Delivery  =${resturant.maximumTimeToDeliver}');
    print('Gallery  =${resturant.gallery}');
    print('Latitude  =${resturant.latitude}');
    print('Logitude  =${resturant.longitude}');
    print('Seo Tags  =${resturant.seoTags}');
    print('Seo Description  =${resturant.seoDescription}');
    print('Status  =${resturant.status}');
    print('Slug  =${resturant.slug}');
    print('Created At  =${resturant.createdAt}');
    print('Updated At  =${resturant.updatedAt}');
    print('Website  =${resturant.website}');
    print('Theme  =${resturant.theme}');
    print('Rating  =${resturant.rating}');
    print('Support Pickup Order  =${resturant.supportPickupOrder}');
    print('Show Slider  =${resturant.showSlider}');
    print('Section ID  =${resturant.sectionId}');
    print('Video Feature  =${resturant.videoFeature}');
    print('Slide BG Image  =${resturant.sliderBgImage}');
    print('Reservation BG Image  =${resturant.reservationBgImage}');
    print('Support Delivery  =${resturant.supportDelivery}');
    print('Support Reservation  =${resturant.supportReservation}');
    print('Returant Name Color  =${resturant.restaurantNameColor}');
    print('Support Token  =${resturant.supportTookan}');
    print('Owner Name  =${resturant.ownerName}');
    print('Owner Email  =${resturant.ownerEmail}');
    print('Owner Phone  =${resturant.ownerPhone}');
  }

  onTap(int i) {
    selectedIndex = i;
    _controller.animateTo(i,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    // setState(() {});
  }

  List<String> names = ['Home', 'Menu', 'Order', 'Booked', 'Report'];

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
                    thumbnail: thumbnail,
                    address: address,
                    restaurantName: resturantname,
                    indexer: (i) {},
                    stringify: (i) {},
                    tabTIme: (i) {},
                    tap: () {},
                    aboutrestro: aboutus,
                  ),
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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        names[0],
                        textAlign: TextAlign.center,
                        style: FontStyleUtilities.t3(
                            context: context,
                            fontWeight: FWT.semiBold,
                            fontColor: ColorUtils.kcWhite),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        names[1],
                        textAlign: TextAlign.center,
                        style: FontStyleUtilities.t3(
                            context: context,
                            fontWeight: FWT.semiBold,
                            fontColor: ColorUtils.kcWhite),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        names[2],
                        textAlign: TextAlign.center,
                        style: FontStyleUtilities.t3(
                            context: context,
                            fontWeight: FWT.semiBold,
                            fontColor: ColorUtils.kcWhite),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        names[3],
                        textAlign: TextAlign.center,
                        style: FontStyleUtilities.t3(
                            context: context,
                            fontWeight: FWT.semiBold,
                            fontColor: ColorUtils.kcWhite),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        names[4],
                        textAlign: TextAlign.center,
                        style: FontStyleUtilities.t3(
                            context: context,
                            fontWeight: FWT.semiBold,
                            fontColor: ColorUtils.kcWhite),
                      ),
                    ),
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
