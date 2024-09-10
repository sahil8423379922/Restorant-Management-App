import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/timetoggle.dart';

class AutoMateTiming extends StatelessWidget {
  const AutoMateTiming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, tittle: 'Automate Timing'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SpaceUtils.ks16.height(),
              TimeToggle(
                name: 'Dine In Automatic Time',
                from: (String? value) {},
                to: (String? value) {},
              ),
              SpaceUtils.ks30.height(),
              TimeToggle(
                name: 'Take Away Automatic Time',
                from: (String? value) {},
                to: (String? value) {},
              ),
              SpaceUtils.ks30.height(),
              TimeToggle(
                name: 'Delivery Automatic Time',
                from: (String? value) {},
                to: (String? value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
