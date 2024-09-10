import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';

typedef DoNothing = void Function();

class ExpandableToggleTile extends StatefulWidget {
  const ExpandableToggleTile({
    Key? key,
    required this.name,
    required this.child,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);
  final String name;
  final Widget child;
  final VoidCallback onChanged;
  final bool? initialValue;
  @override
  _ExpandableToggleTileState createState() => _ExpandableToggleTileState();
}

class _ExpandableToggleTileState extends State<ExpandableToggleTile> {
  @override
  void initState() {
    toShow = widget.initialValue ?? true;
    super.initState();
  }

  bool toShow = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.name,
                style: FontStyleUtilities.h6(
                    context: context, fontWeight: FWT.bold),
              ),
              const Spacer(),
              SizedBox(
                height: 35,
                width: 40,
                child: Switch(
                    activeColor: ColorUtils.kcPrimary,
                    value: toShow,
                    onChanged: (val) {
                      toShow = val;
                      setState(() {});
                    }),
              )
            ],
          ),
          toShow ? widget.child : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
