import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/authentication/otp/otpscreen.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class MObileNumber extends StatefulWidget {
  const MObileNumber({Key? key}) : super(key: key);

  @override
  _MObileNumberState createState() => _MObileNumberState();
}

class _MObileNumberState extends State<MObileNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          SpaceUtils.ks120.height(),
          Text(
            'Enter Your\nMobile Number',
            textAlign: TextAlign.center,
            style:
                FontStyleUtilities.h4(context: context, fontWeight: FWT.bold),
          ),
          SpaceUtils.ks75.height(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SizedBox(
              height: 48,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () async {
                          showOverlayNotification((context) {
                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: SafeArea(
                                child: ListTile(
                                  leading: SizedBox.fromSize(
                                      size: const Size(40, 40),
                                      child: ClipOval(
                                          child: Container(
                                        color: ColorUtils.kcPrimary,
                                        child: const Icon(Icons.done,
                                            color: ColorUtils.kcWhite),
                                      ))),
                                  title: Text(
                                    'OTP has been sent successfully',
                                    style: FontStyleUtilities.t1(
                                        context: context, fontWeight: FWT.bold),
                                  ),
                                  subtitle: Text(
                                    'Check your messages',
                                    style: FontStyleUtilities.t3(
                                        context: context, fontWeight: FWT.bold),
                                  ),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        OverlaySupportEntry.of(context)!
                                            .dismiss();
                                      }),
                                ),
                              ),
                            );
                          }, duration: const Duration(milliseconds: 2000));

                          await Future.delayed(
                              const Duration(milliseconds: 2000));
                          navigateToPage(context, page: const OTP());
                        },
                        child: Container(
                          child: const RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.arrow_back,
                              color: ColorUtils.kcWhite,
                            ),
                          ),
                          height: 46,
                          width: 46,
                          decoration: const BoxDecoration(
                              color: ColorUtils.kcPrimary,
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8))),
                        ),
                      );
                    }),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
          ),
          SpaceUtils.ks30.height(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'By creating an account, you agree to our’s',
                style: FontStyleUtilities.t2(
                    context: context, fontWeight: FWT.semiBold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Privacy Policy ',
                    style: FontStyleUtilities.t2(
                        context: context,
                        fontWeight: FWT.bold,
                        fontColor: ColorUtils.kcPrimary),
                  ),
                  Text(
                    'and ',
                    style: FontStyleUtilities.t2(
                        context: context, fontWeight: FWT.semiBold),
                  ),
                  Text(
                    'Terms of Use',
                    style: FontStyleUtilities.t2(
                        context: context,
                        fontWeight: FWT.bold,
                        fontColor: ColorUtils.kcPrimary),
                  ),
                ],
              )
            ],
          ),
          SpaceUtils.ks16.height(),
        ],
      ),
    );
  }
}
