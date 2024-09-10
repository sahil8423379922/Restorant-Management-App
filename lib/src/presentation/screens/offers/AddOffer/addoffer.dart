import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/items/additems/expandabletoggle.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/dropdownbox.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/presentation/widgets/mastertextfield.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 15, left: 24, right: 24),
        child: MasterButton(
            onTap: () {
              Navigator.pop(context);
            },
            tittle: 'add offer'),
      ),
      appBar: buildAppBar(context, tittle: 'Add Offers'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SpaceUtils.ks16.height(),
              const MasterTextField(tittle: 'Coupon code'),
              SpaceUtils.ks10.height(),
              const MasterTextField(
                tittle: 'Coupon Details',
                height: 48 * 3,
                maxLines: 5,
              ),
              SpaceUtils.ks10.height(),
              ExpandableToggleTile(
                  initialValue: false,
                  name: 'Validity',
                  child: Row(
                    children: [
                      Expanded(
                          child: DropDownBox(
                              width: double.infinity,
                              item: const [
                                '05/07/21',
                                '05/08/21',
                                '05/09/21',
                                '05/10/21',
                                '05/11/21',
                                '05/12/21',
                                '05/13/21',
                              ],
                              value: (v) {})),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          'To',
                          style: FontStyleUtilities.h6(
                            context: context,
                          ),
                        ),
                      ),
                      Expanded(
                          child: DropDownBox(
                              width: double.infinity,
                              item: const [
                                '05/07/21',
                                '05/08/21',
                                '05/09/21',
                                '05/10/21',
                                '05/11/21',
                                '05/12/21',
                                '05/13/21',
                              ],
                              value: (v) {})),
                    ],
                  ),
                  onChanged: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
