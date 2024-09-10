import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:resturant_side/src/extensions/heighextension.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 15, left: 24, right: 24),
          child: MasterButton(onTap: () {}, tittle: 'Confirm'),
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            SpaceUtils.ks120.height(),
            Text(
              'OTP\nVerification',
              textAlign: TextAlign.center,
              style:
                  FontStyleUtilities.h4(context: context, fontWeight: FWT.bold),
            ),
            SpaceUtils.ks75.height(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Code is sent to ',
                  style: FontStyleUtilities.t2(
                      context: context, fontWeight: FWT.semiBold),
                ),
                Text(
                  '+1 123456789',
                  style: FontStyleUtilities.t2(
                      context: context, fontWeight: FWT.bold),
                ),
              ],
            ),
            SpaceUtils.ks16.height(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: PinCodeTextField(
                keyboardType: TextInputType.number,
                appContext: context,
                length: 4,
                onChanged: (v) {},
                animationType: AnimationType.none,
                pinTheme: PinTheme(
                    fieldWidth: 48,
                    fieldHeight: 48,
                    inactiveColor: ColorUtils.kcBlack,
                    borderWidth: 1,
                    selectedColor: ColorUtils.kcGreenColor,
                    activeColor: ColorUtils.kcGreenColor,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SpaceUtils.ks16.height(),
            const TimerWidget()
          ],
        ));
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int myCount = 60;

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (myCount != 0) {
        myCount--;
        setState(() {});
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Code valid for $myCount',
          style: FontStyleUtilities.t2(context: context, fontWeight: FWT.bold),
        ),
        SpaceUtils.ks16.height(),
        myCount == 0
            ? TextButton(
                onPressed: () {
                  myCount = 60;
                  setState(() {});
                  startTimer();
                },
                child: Text(
                  'Resend',
                  style: FontStyleUtilities.t2(
                      context: context,
                      fontWeight: FWT.bold,
                      fontColor: ColorUtils.kcPrimary),
                ))
            : const SizedBox()
      ],
    );
  }
}
