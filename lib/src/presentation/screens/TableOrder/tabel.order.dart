import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';
import 'package:resturant_side/src/presentation/widgets/smallbutton.dart';
import 'package:resturant_side/src/presentation/widgets/widgetexporter.dart';

class TableOrder extends StatelessWidget {
  const TableOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 10, left: 24, right: 24, top: 10),
        child: MasterButton(
            onTap: () {
              Navigator.pop(context);
            },
            tittle: 'EDIT ORDER'),
      ),
      appBar: AppBar(
          foregroundColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlack,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Table 10',
            style: FontStyleUtilities.h3(
                fontColor: isDark ? ColorUtils.kcWhite : ColorUtils.kcBlack,
                fontWeight: FWT.medium,
                context: context),
          )),
      body: Column(
        children: [
          SpaceUtils.ks30.height(),
          Text(
            '05:36',
            style: FontStyleUtilities.h2(
                context: context,
                fontColor: ColorUtils.kcPrimary,
                fontWeight: FWT.medium),
          ),
          SpaceUtils.ks16.height(),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              return TableDetailTile(orderName: orders[index]);
            },
          ),
        ],
      ),
    );
  }
}

class TableDetailTile extends StatefulWidget {
  const TableDetailTile({
    Key? key,
    required this.orderName,
  }) : super(key: key);
  final String orderName;
  @override
  State<TableDetailTile> createState() => _TableDetailTileState();
}

class _TableDetailTileState extends State<TableDetailTile> {
  bool isDelivered = false;
  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 15),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeliveryToggle(
            isDelivered: (value) {
              isDelivered = value;
              setState(() {});
            },
            onTap: () {},
          ),
          SpaceUtils.ks16.width(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.orderName,
                style: FontStyleUtilities.t2(
                    fontWeight: FWT.semiBold, context: context),
              ),
              Text(
                isDelivered ? 'Delivered' : 'Pending',
                style: FontStyleUtilities.t5(
                    fontWeight: FWT.semiBold, context: context),
              )
            ],
          ),
          const Spacer(),
          !isDelivered
              ? SmallButton(
                  name: 'Cancel',
                  onTap: () {},
                  color: ColorUtils.kcPrimary,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class DeliveryToggle extends StatefulWidget {
  const DeliveryToggle({
    Key? key,
    required this.isDelivered,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<bool> isDelivered;
  final VoidCallback onTap;

  @override
  State<DeliveryToggle> createState() => _DeliveryToggleState();
}

class _DeliveryToggleState extends State<DeliveryToggle> {
  bool isDelivered = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isDelivered = !isDelivered;
        setState(() {
          widget.isDelivered(isDelivered);
          widget.onTap();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 100,
        ),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDelivered ? ColorUtils.kcGreenColor : ColorUtils.kcWhite,
            border: Border.all(
                color:
                    isDelivered ? ColorUtils.kcGreenColor : Colors.grey[400]!,
                width: 1)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Icon(
              Icons.done,
              size: 12,
              color:
                  isDelivered ? ColorUtils.kcWhite : ColorUtils.kcTransparent,
            ),
          ),
        ),
      ),
    );
  }
}

List<String> orders = ['Farmhouse Pizza', 'Brown Bread', 'Farmhouse Pizza'];
