import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/screens/offers/AddOffer/addoffer.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Offers',
              style: FontStyleUtilities.h4(
                context: context,
                fontWeight: FWT.medium,
              ),
            ),
            SpaceUtils.ks10.width(),
            GestureDetector(
              onTap: () {
                navigateToPage(context, page: const AddOffer());
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor:
                    isDark ? ColorUtils.kcBlueButton : ColorUtils.kcWhite,
                foregroundColor: ColorUtils.kcWhite,
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Available offer',
                style: FontStyleUtilities.t1(
                    context: context, fontWeight: FWT.bold),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return const OfferTile(
                  isActive: true,
                );
              },
            ),
            SpaceUtils.ks30.height(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Expired Offers',
                style: FontStyleUtilities.t1(
                    context: context, fontWeight: FWT.bold),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return const OfferTile(
                  isActive: false,
                );
              },
            ),
            SpaceUtils.ks65.height()
          ],
        ),
      ),
    );
  }
}

class OfferTile extends StatelessWidget {
  const OfferTile({Key? key, required this.isActive}) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 11),
      child: DottedBorder(
        dashPattern: [3, 3],
        color: ColorUtils.kcBlueButton.withOpacity(.70),
        padding: EdgeInsets.zero,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        strokeCap: StrokeCap.round,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Coupon code : ZBS192',
                style: FontStyleUtilities.t2(
                  context: context,
                  fontWeight: FWT.bold,
                ),
              ),
              SpaceUtils.ks10.height(),
              Text(
                '20% off on \$500.00 above order.',
                style: FontStyleUtilities.t4(
                    context: context, fontWeight: FWT.medium),
              ),
              Text(
                'Offer valid till 31st Dec 2021',
                style: FontStyleUtilities.t4(
                    context: context, fontWeight: FWT.medium),
              ),
              isActive
                  ? SizedBox(
                      height: 30,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Deactivate',
                            style: FontStyleUtilities.t2(
                                context: context,
                                fontWeight: FWT.medium,
                                fontColor: ColorUtils.kcPrimary),
                          )),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
