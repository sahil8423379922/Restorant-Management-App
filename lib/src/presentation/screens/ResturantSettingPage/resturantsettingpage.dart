import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/screens/ResturantSettingPage/aboutrestro.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/presentation/widgets/mastertextfield.dart';
import 'package:resturant_side/src/repository/itemrepo.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../db/DatabaseHelper.dart';
import '../../../../db/ResturantDB.dart';
import '../../../api/service/api.dart';

class RestaurantSetting extends StatefulWidget {
  const RestaurantSetting({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantSetting> createState() => _RestaurantSettingState();
}

class _RestaurantSettingState extends State<RestaurantSetting> {
  var userid = "";
  var resturantglry = [];
  var resturantthumbnail = "";
  var restophone = "";

  Future<void> check_user_already_logged_in() async {
    List<Map<String, dynamic>> users = await DatabaseHelper.instance.getUsers();
    print('Data Received = $users');
    print(users[0]['userid']);

    setState(() {
      userid = users[0]['userid'];
      _fetchRestaurantData(userid);
    });
  }

  Future<void> _fetchRestaurantData(String userid) async {
    RestaurantService _restaurantService = RestaurantService();
    final restuantdata = await _restaurantService.fetchRestaurantData(userid);
    final restuarntgallery = restuantdata?.gallery;
    final restothumbnail = restuantdata?.restaurantThumbnail;
    final rphone = restuantdata?.phone;

    print(restothumbnail);
    setState(() {
      resturantglry = jsonDecode(restuarntgallery!);
      resturantthumbnail = restothumbnail!;
      restophone = rphone!;
    });

    //final resturantdata =jsonEncode(restuantdata);

    print("user ID received =" + userid);
    print(restothumbnail);
    print(restophone);
    print(jsonDecode(restuarntgallery!).length);
    //print("Request Payload: ${restuantdata?.gallery}");

    //print("Gallery Data Received from the DB 2 $restuantdata");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_user_already_logged_in();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, tittle: 'Restaurant'),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 24, right: 24, top: 10),
        child: MasterButton(
            onTap: () {
              popToTheHome(context);
            },
            tittle: 'Close'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 130 + 295,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          width: double.infinity,
                          height: 253,
                          child: Image.network(
                            "https://www.guildresto.com/uploads/restaurant/thumbnail/" +
                                resturantthumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          width: MediaQuery.of(context).size.width,
                          bottom: 0,
                          child: RestaurantInfo()),
                    ],
                  ),
                ),
                SpaceUtils.ks20.height(),

                //gallery loading image

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 024),
                  child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      itemCount: resturantglry.length,
                      itemBuilder: (context, int index) => StaggeredContainer(
                            child: Image.network(
                              "https://www.guildresto.com/uploads/restaurant/gallery/" +
                                  resturantglry[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                      staggeredTileBuilder: (index) => StaggeredTile.count(
                          (index % 10 == 0) ? 2 : 1,
                          (index % 10 == 0) ? 2 : 1)),
                ),

                SpaceUtils.ks16.height(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 24),
                //   child: Column(
                //     children: [
                //       const MasterTextField(tittle: 'Facebook Link'),
                //       SpaceUtils.ks18.height(),
                //       const MasterTextField(tittle: 'Instagram Link'),
                //       SpaceUtils.ks18.height(),
                //       const MasterTextField(tittle: 'Twitter Link'),
                //       SpaceUtils.ks30.height(),
                //     ],
                //   ),
                // ),
                SpaceUtils.ks30.height()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantInfo extends StatefulWidget {
  const RestaurantInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchRestaurantData();
  }

  var name = "";
  var aboutresto = "";
  var restoadddress = "";
  var phoone = "";

  Future<void> _fetchRestaurantData() async {
    List<Map<String, dynamic>> resturant =
        await ResturantHelper.instance.getDetails();
    print("Data Received from the DB 2 $resturant");

    setState(() {
      aboutresto = resturant[0]['aboutus'];
      restoadddress = resturant[0]['address'];
      phoone = resturant[0]['phone'];
      name = resturant[0]['name'];
    });
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoone,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(21),
      width: double.infinity,
      height: 310,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: ColorUtils.kcTransparent.withOpacity(.16),
                offset: const Offset(0, 4),
                blurRadius: 8)
          ],
          color: isDark ? ColorUtils.kcSmoothBlack : ColorUtils.kcWhite,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        Text(name,
            style:
                FontStyleUtilities.h4(context: context, fontWeight: FWT.bold)),
        SpaceUtils.ks10.height(),

        SizedBox(
            width: double.infinity,
            height: 45,
            child: AboutRestro(para: aboutresto)),

        //const RestaurantStatus(),
        SpaceUtils.ks16.height(),
        Text('Restaurant Address',
            style: FontStyleUtilities.t2(
                context: context, fontWeight: FWT.semiBold)),
        const SizedBox(height: 4),
        SingleChildScrollView(
          child: SizedBox(
            height: 40,
            child: Text(
              restoadddress,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Text('Expertise 1 . Expertise 2',
        //     style:
        //         FontStyleUtilities.t2(context: context, fontWeight: FWT.bold)),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  _makePhoneCall;
                },
                child: SimpleIconWrapper(name: 'Call', image: IconUtil.call)),
            SimpleIconWrapper(name: 'Location', image: IconUtil.location),
            // SimpleIconWrapper(name: 'Opening', image: IconUtil.add)
          ],
        )
      ]),
    );
  }
}

class RestaurantStatus extends StatefulWidget {
  const RestaurantStatus({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantStatus> createState() => _RestaurantStatusState();
}

class _RestaurantStatusState extends State<RestaurantStatus> {
  bool isOpen = true;
  toggle() {
    isOpen = !isOpen;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: isOpen ? ColorUtils.kcGreenColor : ColorUtils.kcPrimary,
              width: 1.5)),
      height: 30,
      child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            toggle();
          },
          child: Text(isOpen ? 'STATUS: OPEN' : 'STATUS: CLOSE',
              style: FontStyleUtilities.t2(
                  context: context,
                  fontWeight: FWT.semiBold,
                  fontColor: isOpen
                      ? ColorUtils.kcGreenColor
                      : ColorUtils.kcPrimary))),
    );
  }
}

class StaggeredContainer extends StatelessWidget {
  const StaggeredContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: isDark ? ColorUtils.kcCallIconColor : ColorUtils.kcWhite,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.kcTransparent.withOpacity(.16),
              offset: const Offset(0, 3),
              blurRadius: 6,
            ),
          ]),
      child: child,
    );
  }
}

class SimpleIconWrapper extends StatelessWidget {
  const SimpleIconWrapper({Key? key, required this.image, required this.name})
      : super(key: key);
  final String image, name;

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.grey.withOpacity(0.2)
                  : ColorUtils.kcIconBackgroundColor.withOpacity(.70)),
          child: Center(
            child: SvgPicture.asset(image,
                color: isDark
                    ? ColorUtils.kcWhite
                    : ColorUtils.kcCallIconColor.withOpacity(.90)),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          name,
          style: FontStyleUtilities.t2(
            context: context,
          ),
        )
      ],
    );
  }
}
