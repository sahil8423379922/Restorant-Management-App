import 'package:flutter/material.dart';
import 'package:resturant_side/src/extensions/heighextension.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/constatns/textstyle.dart';

import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';

class Tables extends StatefulWidget {
  const Tables({Key? key}) : super(key: key);

  @override
  State<Tables> createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  final List<String> _value = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  late ValueNotifier valueNotifier;

  @override
  void initState() {
    super.initState();

    valueNotifier = ValueNotifier(_value);
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tables',
              style: FontStyleUtilities.h4(
                context: context,
                fontWeight: FWT.medium,
              ),
            ),
            SpaceUtils.ks10.width(),
            GestureDetector(
              onTap: () {
                _value.insert(_value.length, (_value.length + 1).toString());
                setState(() {});
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
        foregroundColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlueButton,
      ),
      body: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, model, child) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              FreeTable(
                times: valueNotifier.value,
                stringify: (value) {},
                tap: () {},
                onLongPress: (index) {
                  _value.removeAt(index);
                  setState(() {});
                },
              ),
              SpaceUtils.ks100.height()
            ],
          ),
        ),
      ),
    );
  }
}

typedef Indexer = Function(int);
typedef Stringify = Function(String);

class FreeTable extends StatefulWidget {
  const FreeTable({
    Key? key,
    required this.times,
    required this.stringify,
    required this.tap,
    required this.onLongPress,
  }) : super(key: key);

  final List<String> times;
  final Stringify stringify;
  final VoidCallback tap;
  final ValueChanged<int> onLongPress;

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
          margin: const EdgeInsets.only(top: 22, left: 12, right: 12),
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
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                backgroundColor: ColorUtils.kcTransparent,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: isDark
                                          ? ColorUtils.kcSmoothBlack
                                          : ColorUtils.kcWhite,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SpaceUtils.ks10.height(),
                                      Text(
                                        'Are you sure ?',
                                        style: FontStyleUtilities.h5(
                                            context: context,
                                            fontWeight: FWT.bold),
                                      ),
                                      SpaceUtils.ks20.height(),
                                      Text(
                                          'By tapping on remove this table will not visible in client side.',
                                          textAlign: TextAlign.center,
                                          style: FontStyleUtilities.h6(
                                              context: context,
                                              fontWeight: FWT.bold)),
                                      SpaceUtils.ks30.height(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        child: SizedBox(
                                          height: 40,
                                          child: MasterButton(
                                              onTap: () {
                                                widget.onLongPress(index);
                                                Navigator.pop(context);
                                              },
                                              tittle: 'Remove'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedtime == index
                            ? ColorUtils.kcBlueButton
                            : isDark
                                ? ColorUtils.kcSmoothBlack
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
      ],
    );
  }
}
