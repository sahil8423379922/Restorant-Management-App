import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:resturant_side/src/extensions/heighextension.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/constatns/spaces.dart';
import 'package:resturant_side/src/presentation/constatns/textstyle.dart';
import 'package:resturant_side/src/presentation/screens/ManageTeam/AddTeamMate/addteammate.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';
import 'package:resturant_side/src/presentation/widgets/customiconbutton.dart';
import 'package:resturant_side/src/presentation/widgets/smallbutton.dart';
import 'package:resturant_side/src/utils/iconutil.dart';
import 'package:resturant_side/src/utils/navigationutil.dart';

class ManageTeamMember extends StatelessWidget {
  const ManageTeamMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Manage Team',
              style: FontStyleUtilities.h4(
                context: context,
                fontWeight: FWT.medium,
              ),
            ),
            SpaceUtils.ks10.width(),
            GestureDetector(
              onTap: () {
                navigateToPage(context, page: const AddTeamMate());
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
      body: Column(
        children: [
          SpaceUtils.ks30.height(),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: members.length,
            itemBuilder: (BuildContext context, int index) {
              return MangeMemberTile(memberName: members[index]);
            },
          ),
        ],
      ),
    );
  }
}

class MangeMemberTile extends StatefulWidget {
  const MangeMemberTile({
    Key? key,
    required this.memberName,
  }) : super(key: key);
  final String memberName;
  @override
  State<MangeMemberTile> createState() => _MangeMemberTileState();
}

class _MangeMemberTileState extends State<MangeMemberTile> {
  bool isDelivered = false;
  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 15),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.memberName,
                style: FontStyleUtilities.t2(
                    context: context, fontWeight: FWT.medium),
              ),
              Text(
                '${widget.memberName}@gmail.com',
                style: FontStyleUtilities.t5(
                    context: context, fontWeight: FWT.medium),
              )
            ],
          ),
          const Spacer(),
          SmallButton(
            name: 'Revoke',
            onTap: () {},
            color: ColorUtils.kcPrimary,
          )
        ],
      ),
    );
  }
}

List<String> members = ['Thomas', 'Mike', 'Ken Miles'];
