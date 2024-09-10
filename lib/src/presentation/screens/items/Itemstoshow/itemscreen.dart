import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/paadings.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/screens/Settings/settings.dart';
import 'package:resturant_side/src/presentation/screens/items/EditItem/edititemscreen.dart';
import 'package:resturant_side/src/presentation/screens/items/additems/additem.dart';
import 'package:resturant_side/src/presentation/screens/notification/notification.dart';
import 'package:resturant_side/src/presentation/widgets/customiconbutton.dart';
import 'package:resturant_side/src/repository/itemrepo.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Items',
              style: FontStyleUtilities.h4(
                context: context,
                fontWeight: FWT.bold,
              ),
            ),
            SpaceUtils.ks10.width(),
            GestureDetector(
              onTap: () {
                navigateToPage(context, page: const AddItem());
              },
              child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isDark ? ColorUtils.kcBlueButton : ColorUtils.kcBlack,
                  child: Icon(Icons.add),
                  foregroundColor: ColorUtils.kcWhite),
            )
          ],
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
            navigateToPage(context, page: const SettingsPage());
          },
          child: SvgPicture.asset(
            IconUtil.menu,
            height: 20,
            color: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: KPadding.kp24,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SpaceUtils.ks24.height(),
            Text(
              'Lunch',
              style: FontStyleUtilities.h5(
                  context: context, fontWeight: FWT.semiBold),
            ),
            SpaceUtils.ks10.height(),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ItemTile(
                  name: itmes[index].name,
                  image: itmes[index].image,
                  price: itmes[index].price,
                  isVeg: itmes[index].isVeg,
                  onChange: (bool value) {},
                );
              },
            ),
            SpaceUtils.ks30.height(),
            Text(
              'Drinks',
              style: FontStyleUtilities.h5(
                  context: context, fontWeight: FWT.semiBold),
            ),
            SpaceUtils.ks10.height(),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ItemTile(
                  name: itmes[index].name,
                  image: itmes[index].image,
                  price: itmes[index].price,
                  isVeg: itmes[index].isVeg,
                  onChange: (bool value) {
                    // print('i am $index and my value is $value ');
                  },
                );
              },
            ),
            SpaceUtils.ks75.height(),
          ],
        ),
      ),
    );
  }
}

class ItemTile extends StatefulWidget {
  const ItemTile({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.isVeg,
    required this.onChange,
  }) : super(key: key);
  final String name, image;
  final int price;
  final bool isVeg;
  final ValueChanged<bool> onChange;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 96,
            width: 96,
            child: Stack(
              children: [
                SizedBox(
                  height: 96,
                  width: 96,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Mark(
                    isVeg: widget.isVeg,
                  ),
                ),
              ],
            ),
          ),
          SpaceUtils.ks16.width(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: FontStyleUtilities.t2(
                            context: context, fontWeight: FWT.semiBold),
                      ),
                      Text(
                        '\$${widget.price}',
                        style: FontStyleUtilities.t2(
                            context: context, fontWeight: FWT.semiBold),
                      ),
                      SpaceUtils.ks30.height(),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToPage(context,
                          page: EditItem(
                            image: widget.image,
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: ColorUtils.kcBlueButton),
                      child: Text(
                        'Edit',
                        style: FontStyleUtilities.t2(
                            context: context,
                            fontWeight: FWT.semiBold,
                            fontColor: ColorUtils.kcWhite),
                      ),
                    ),
                  )
                ],
              ),
              Switch(
                  activeColor: ColorUtils.kcPrimary,
                  value: isSelect,
                  onChanged: (val) {
                    isSelect = val;
                    widget.onChange(val);
                    setState(() {});
                  })
            ],
          ))
        ],
      ),
    );
  }
}

class Mark extends StatelessWidget {
  const Mark({
    Key? key,
    required this.isVeg,
  }) : super(key: key);
  final bool isVeg;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(3),
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          color: ColorUtils.kcWhite,
          border: Border.all(
              color: isVeg ? ColorUtils.kcGreenColor : ColorUtils.kcPrimary,
              width: 1.4),
        ),
        child: CircleAvatar(
          radius: 6,
          backgroundColor:
              isVeg ? ColorUtils.kcGreenColor : ColorUtils.kcPrimary,
        ));
  }
}
