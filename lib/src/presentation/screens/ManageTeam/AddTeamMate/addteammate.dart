import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/masterbutton.dart';
import 'package:resturant_side/src/presentation/widgets/mastertextfield.dart';

class AddTeamMate extends StatefulWidget {
  const AddTeamMate({Key? key}) : super(key: key);

  @override
  _AddTeamMateState createState() => _AddTeamMateState();
}

class _AddTeamMateState extends State<AddTeamMate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: ColorUtils.kcTransparent,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: MasterButton(
            onTap: () {
              Navigator.pop(context);
            },
            tittle: 'ADD TEAM MATE'),
      ),
      appBar: buildAppBar(context, tittle: 'Add Team Mate'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            children: [
              const MasterTextField(tittle: 'Name'),
              SpaceUtils.ks18.height(),
              const MasterTextField(tittle: 'Email'),
              SpaceUtils.ks18.height(),
              const MasterTextField(tittle: 'Password', obscureText: true)
            ],
          ),
        ),
      ),
    );
  }
}
