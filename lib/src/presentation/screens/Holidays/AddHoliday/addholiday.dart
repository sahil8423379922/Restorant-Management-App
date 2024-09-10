import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/Home/mainhome.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/presentation/widgets/mastertextfield.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class AddHoliday extends StatelessWidget {
  const AddHoliday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: Container(
        color: isDark ? ColorUtils.kcbackDarkColor : ColorUtils.kcWhite,
        padding: const EdgeInsets.all(15),
        child: MasterButton(
            onTap: () {
              popToTheHome(context);
            },
            tittle: 'Add'),
      ),
      appBar: buildAppBar(context, tittle: 'Add Holiday'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      isDark ? ColorUtils.kcSmoothBlack : ColorUtils.kcWhite,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: ColorUtils.kcTransparent.withOpacity(.16),
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2 - 56,
                child: SfDateRangePickerTheme(
                    data: SfDateRangePickerThemeData(
                        // todayTextStyle: const TextStyle(
                        //   color: kcGradient1,
                        // ),
                        // backgroundColor: kcCalanderbc,
                        // selectionTextStyle: const TextStyle(
                        //   color: kcwhite,
                        // ),
                        ),
                    child: SfDateRangePicker(
                      headerHeight: 50,
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs a) {},
                      // todayHighlightColor: kcCalanderbc,
                      // controller: _controller,
                      enablePastDates: false,
                      showNavigationArrow: true,
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                    )),
                padding: const EdgeInsets.all(16),
              ),
              SpaceUtils.ks30.height(),
              const MasterTextField(tittle: 'Holiday Name')
            ],
          ),
        ),
      ),
    );
  }
}
