import 'package:flutter/widgets.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';

// ignore: constant_identifier_names
enum TagName { OCCU, COMP, INPROGRESS, DINEIN }

class TagWidget extends StatefulWidget {
  const TagWidget({Key? key, this.tagName}) : super(key: key);
  final TagName? tagName;

  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  TagConfig getTag() {
    switch (widget.tagName) {
      case TagName.COMP:
        return TagConfig(color: ColorUtils.kcComp, name: 'Completed');
      case TagName.INPROGRESS:
        return TagConfig(color: ColorUtils.kcInProgress, name: 'In-Progress');
      case TagName.OCCU:
        return TagConfig(color: ColorUtils.kcOccupied, name: 'Occupied');
      case TagName.DINEIN:
        return TagConfig(color: ColorUtils.kcOccupied, name: 'Dine in');
      default:
        return TagConfig(color: ColorUtils.kcOccupied, name: 'Occupied');
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

class TagConfig {
  TagConfig({required this.color, required this.name});
  final Color color;
  final String name;
}
