import 'package:flutter/material.dart';
import 'package:resturant_side/src/presentation/constatns/colors.dart';
import 'package:resturant_side/src/presentation/constatns/exporter.dart';
import 'package:resturant_side/src/presentation/widgets/dropdownbox.dart';

class TimeToggle extends StatefulWidget {
  const TimeToggle({
    Key? key,
    required this.name,
    required this.from,
    required this.to,
  }) : super(key: key);
  final String name;
  final ValueChanged<String?> from;
  final ValueChanged<String?> to;

  @override
  _TimeToggleState createState() => _TimeToggleState();
}

class _TimeToggleState extends State<TimeToggle> {
  bool toShow = false;
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
                      // widget.onChange(val);
                      setState(() {});
                    }),
              )
            ],
          ),
          Text(
            'Set time slot for service availablity.',
            style: FontStyleUtilities.t4(
              context: context,
            ),
          ),
          const SizedBox(height: 6),
          toShow
              ? Row(
                  children: [
                    Expanded(
                        child: DropDownBox(
                            width: double.infinity,
                            item: const [
                              '01:30 PM',
                              '02:00 PM',
                              '03:00PM',
                              '03:30 PM',
                              '04:00 PM'
                            ],
                            value: widget.from)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'To',
                        style: FontStyleUtilities.h6(
                          context: context,
                        ),
                      ),
                    ),
                    Expanded(
                        child: DropDownBox(
                            width: double.infinity,
                            item: const [
                              '01:30 PM',
                              '02:00 PM',
                              '03:00PM',
                              '03:30 PM',
                              '04:00 PM'
                            ],
                            value: widget.to)),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
