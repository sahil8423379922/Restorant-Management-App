// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';

enum RoleName { ADMIN, MANAGER, OWNER, WORKER }

class RoleManger extends StatefulWidget {
  const RoleManger({Key? key, this.roleName}) : super(key: key);
  final RoleName? roleName;

  @override
  _RoleMangerState createState() => _RoleMangerState();
}

class _RoleMangerState extends State<RoleManger> {
  RoleModel getTag() {
    switch (widget.roleName) {
      case RoleName.MANAGER:
        return RoleModel(color: ColorUtils.kcComp, name: 'MANAGER');
      case RoleName.OWNER:
        return RoleModel(color: ColorUtils.kcInProgress, name: 'OWNER');
      case RoleName.ADMIN:
        return RoleModel(color: ColorUtils.kcComp, name: 'ADMIN');
      case RoleName.WORKER:
        return RoleModel(color: ColorUtils.kcOccupied, name: 'WORKER');
      default:
        return RoleModel(color: ColorUtils.kcOccupied, name: 'WORKER');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: getTag().color, borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        getTag().name.toUpperCase(),
        style: FontStyleUtilities.t4(
            context: context,
            fontWeight: FWT.bold,
            fontColor: ColorUtils.kcWhite),
      ),
    );
  }
}

class RoleModel {
  RoleModel({required this.color, required this.name});
  final Color color;
  final String name;
}
