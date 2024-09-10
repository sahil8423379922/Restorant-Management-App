import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/appbar.dart';
import 'package:resturant_side/src/presentation/widgets/commonshadowcontainer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: buildAppBar(context, tittle: 'Notification'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaceUtils.ks20.height(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'New Notification',
                style: FontStyleUtilities.h6(
                    context: context, fontWeight: FWT.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationTile(
                  notificationModel: notifications[index],
                );
              },
            ),
            SpaceUtils.ks20.height(),
            SpaceUtils.ks20.height(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Earlier Notification',
                style: FontStyleUtilities.h6(
                    context: context, fontWeight: FWT.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationTile(
                  notificationModel: notifications[index],
                );
              },
            ),
            SpaceUtils.ks100.height(),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({Key? key, required this.notificationModel})
      : super(key: key);
  final NotificationModel notificationModel;
  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
      margin: const EdgeInsets.only(top: 10, left: 24, right: 24),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notificationModel.tittle,
            style: FontStyleUtilities.t2(
                context: context, fontWeight: FWT.semiBold),
          ),
          SpaceUtils.ks7.height(),
          Text(
            notificationModel.time,
            style: FontStyleUtilities.t2(
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}

List<NotificationModel> notifications = [
  NotificationModel(
    time: '11:30 PM',
    tittle: 'New customer arrived at table no. 10.',
  ),
  NotificationModel(
    time: '9:30 PM',
    tittle: 'Customer at Table no. 5 has updated order.',
  ),
  NotificationModel(
    time: '10:30 PM',
    tittle: 'New order from the id #123565',
  ),
  NotificationModel(
    time: '8:30 PM',
    tittle: 'Order id #12356 is waiting for receiver',
  ),
  NotificationModel(
    time: '7:30 PM',
    tittle: 'Customer at table no. 10 have added some items in existing order',
  ),
];

class NotificationModel {
  NotificationModel({
    required this.time,
    required this.tittle,
  });
  final String tittle, time;
}
