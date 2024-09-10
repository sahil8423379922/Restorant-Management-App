import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/screens/Home/mainhome.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpaceUtils.ks60.height(),
                  Text(
                    'Log In',
                    style: FontStyleUtilities.h2(
                        context: context, fontWeight: FWT.semiBold),
                  ),
                  SpaceUtils.ks65.height(),
                  const MasterTextField(
                    tittle: 'Email Address',
                    hint: 'example@gmail.com',
                  ),
                  SpaceUtils.ks24.height(),
                  const MasterTextField(
                    tittle: 'Password',
                    hint: '********************',
                    obscureText: true
                  ),
                  SpaceUtils.ks50.height(),
                  MasterButton(
                    onTap: () {
                      navigateToPage(context, page: const HomeMain());
                    },
                    tittle: 'LOG IN',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
