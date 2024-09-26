import 'package:flutter/material.dart';
import 'package:resturant_side/db/DatabaseHelper.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/Holidays/Holidays/holidays.dart';
import 'package:resturant_side/src/presentation/screens/LoyaltyProgram/loyaltyprogram.dart';
import 'package:resturant_side/src/presentation/screens/ManageTeam/ManageTeam/mangeteammembers.dart';
import 'package:resturant_side/src/presentation/screens/ResturantSettingPage/resturantsettingpage.dart';
import 'package:resturant_side/src/presentation/screens/Tables/tables.dart';
import 'package:resturant_side/src/presentation/screens/authentication/login/login.dart';
import 'package:resturant_side/src/presentation/screens/automatetiming/automatetiming.dart';
import 'package:resturant_side/src/presentation/screens/items/additems/additem.dart';
import 'package:resturant_side/src/presentation/screens/offers/Offers/offers.dart';
import 'package:resturant_side/src/presentation/screens/userprofile/Userprofile.dart';
import 'package:resturant_side/src/presentation/widgets/roletag.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

import '../../../api/model/parsedjson.dart';
import '../../../api/service/api.dart';

class SettingsPage extends StatefulWidget {
  final List<String> thumbnail;
  final String name;
  final String aboutus;
  final String address;
  const SettingsPage(
      {Key? key,
      required this.name,
      required this.aboutus,
      required this.address,
      required this.thumbnail})
      : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final resturantinfo;
  var name = '';

  RestaurantService _restaurantService = RestaurantService();

  Future<void> _fetchRestaurantData() async {
    final restuantdata = await _restaurantService.fetchRestaurantData();

    if (restuantdata != null) {
      print("Name of the restaurant = ${restuantdata.name}");
    } else {
      print("No restaurant data received");
    }

    setState(() {
      name = restuantdata.name;
      resturantinfo = restuantdata;
    });
  }

  Future<void> deleteAllUsers() async {
    final dbHelper = DatabaseHelper.instance;
    final db = await dbHelper.database;
    await db.delete('users');
    List<Map<String, dynamic>> users = await DatabaseHelper.instance.getUsers();
    if (users.isEmpty) {
      navigateToPage(context, page: const Login());
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          foregroundColor:
              isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
          title: Text(
            'Settings',
            style:
                FontStyleUtilities.h3(context: context, fontWeight: FWT.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpaceUtils.ks30.height(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  name,
                  style: FontStyleUtilities.h3(
                      context: context, fontWeight: FWT.bold),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: RoleManger(
                  roleName: RoleName.ADMIN,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 24),
              //   child: AddItemToggleTile(name: 'OPEN', onChange: (value) {}),
              // ),
              // SettingTile(
              //     name: 'Automate Timing',
              //     onTap: () {
              //       navigateToPage(context, page: const AutoMateTiming());
              //     }),
              // SettingTile(
              //     name: 'Offers',
              //     onTap: () {
              //       navigateToPage(context, page: const Offers());
              //     }),
              // SettingTile(
              //     name: 'Loyalty Program',
              //     onTap: () {
              //       navigateToPage(context, page: const LoyaltyProgram());
              //     }),
              // SettingTile(
              //     name: 'Table',
              //     onTap: () {
              //       navigateToPage(context, page: const Tables());
              //     }),
              // SettingTile(
              //     name: 'Team',
              //     onTap: () {
              //       navigateToPage(context, page: const ManageTeamMember());
              //     }),

              SettingTile(
                  name: 'User Profile',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserProfile(),
                    ));
                  }),
              SettingTile(
                  name: 'About Restaurant',
                  onTap: () {
                    navigateToPage(context,
                        page: RestaurantSetting(resturantinfo: resturantinfo));
                  }),
              // SettingTile(
              //     name: 'Holidays',
              //     onTap: () {
              //       navigateToPage(context, page: const Holidays());
              //     }),
              SpaceUtils.ks40.height(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: MasterButton(
                        onTap: () {
                          // navigateToPage(context, page: const Login());
                          deleteAllUsers();
                        },
                        tittle: 'LOG OUT',
                        isOutlined: true,
                      ),
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile({Key? key, required this.name, required this.onTap})
      : super(key: key);
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: MaterialButton(
        onPressed: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                style: FontStyleUtilities.h6(
                    context: context, fontWeight: FWT.semiBold)),
            const RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                ))
          ],
        ),
      ),
    );
  }
}
