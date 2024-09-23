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

class RestaurantSetting extends StatefulWidget {
  final String about;
  final String name;
  final String address;
  final List<String> thumbnail;
  const RestaurantSetting(
      {Key? key,
      required this.about,
      required this.name,
      required this.address,
      required this.thumbnail})
      : super(key: key);

  @override
  State<RestaurantSetting> createState() => _RestaurantSettingState();
}

class _RestaurantSettingState extends State<RestaurantSetting> {
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
                          child: Image.asset(
                            itmes[1].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          width: MediaQuery.of(context).size.width,
                          bottom: 0,
                          child: RestaurantInfo(
                              thumbnail: widget.thumbnail,
                              address: widget.address,
                              name: widget.name,
                              aboutus: widget.about)),
                    ],
                  ),
                ),
                SpaceUtils.ks20.height(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 024),
                  child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      itemCount: itmes.length,
                      itemBuilder: (context, int index) => StaggeredContainer(
                            child: Image.asset(
                              itmes[index].image,
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
  final String name;
  final String aboutus;
  final List<String> thumbnail;
  final String address;

  const RestaurantInfo(
      {Key? key,
      required this.name,
      required this.aboutus,
      required this.address,
      required this.thumbnail})
      : super(key: key);

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(21),
      width: double.infinity,
      height: 295,
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
        Text(widget.name,
            style:
                FontStyleUtilities.h4(context: context, fontWeight: FWT.bold)),
        SpaceUtils.ks10.height(),

        SizedBox(
            width: double.infinity,
            height: 45,
            child: AboutRestro(para: widget.aboutus)),

        //const RestaurantStatus(),
        SpaceUtils.ks16.height(),
        Text('Restaurant',
            style: FontStyleUtilities.t2(
                context: context, fontWeight: FWT.semiBold)),
        const SizedBox(height: 4),
        Text(
          widget.address,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        // Text('Expertise 1 . Expertise 2',
        //     style:
        //         FontStyleUtilities.t2(context: context, fontWeight: FWT.bold)),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            SimpleIconWrapper(name: 'Call', image: IconUtil.call),
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
