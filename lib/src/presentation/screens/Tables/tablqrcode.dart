import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';

class TableQRGen extends StatelessWidget {
  const TableQRGen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, tittle: 'Table 10'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'QR code generated for\nTable Number 10',
                style: FontStyleUtilities.h6(
                    context: context, fontWeight: FWT.bold),
                textAlign: TextAlign.center,
              ),
              SpaceUtils.ks30.height(),
              Image.asset(
                'asset/tempimages/qr/qr.png',
                scale: 3,
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 15, left: 24, right: 24),
          child: MasterButton(onTap: () {}, tittle: 'PRINT'),
        ));
  }
}
