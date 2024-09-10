import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/screens/Tables/tablqrcode.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

typedef Indexer = Function(int);
typedef Stringify = Function(String);

class FreeTable extends StatefulWidget {
  const FreeTable({
    Key? key,
    required this.times,
    required this.stringify,
    required this.tap,
  }) : super(key: key);

  final List<String> times;
  final Stringify stringify;
  final VoidCallback tap;

  @override
  State<FreeTable> createState() => _FreeTableState();
}

class _FreeTableState extends State<FreeTable> {
  int selectedtime = 0;
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 20, left: 27, right: 24, bottom: 23),
          decoration: BoxDecoration(
            color: isDark ? ColorUtils.kcSmoothBlack : ColorUtils.kcWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(-1, 7),
                  blurRadius: 39,
                  color: ColorUtils.kcTransparent.withOpacity(.13))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Table',
                style: FontStyleUtilities.h5(
                    context: context, fontWeight: FWT.semiBold),
              ),
              SpaceUtils.ks18.height(),
              GridView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.2),
                itemCount: widget.times.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      selectedtime = index;
                      widget.stringify(widget.times[selectedtime]);
                      widget.tap();
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedtime == index
                            ? ColorUtils.kcBlueButton
                            : isDark
                                ? ColorUtils.kcbackDarkColor
                                : ColorUtils.kcWhite,
                        borderRadius: BorderRadius.circular(4),
                        border: selectedtime == index
                            ? Border.all(color: ColorUtils.kcBlueButton)
                            : Border.all(color: ColorUtils.kcBlueButton),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.times[index],
                            style: FontStyleUtilities.h2(
                                context: context,
                                fontColor: selectedtime == index
                                    ? ColorUtils.kcWhite
                                    : ColorUtils.kcBlueButton,
                                fontWeight: FWT.semiBold),
                          ),
                          Text(
                            'Table',
                            style: FontStyleUtilities.t1(
                                context: context,
                                fontColor: selectedtime == index
                                    ? ColorUtils.kcWhite
                                    : ColorUtils.kcBlueButton,
                                fontWeight: FWT.semiBold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SpaceUtils.ks30.height(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MasterButton(
              onTap: () {
                navigateToPage(context, page: const TableQRGen());
              },
              tittle: 'SCAN TABLE QR CODE'),
        )
      ],
    );
  }
}
