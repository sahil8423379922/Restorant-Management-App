// import 'package:flutter/material.dart';
// import 'package:resturant_side/src/presentation/constatns/colors.dart';
// import 'package:resturant_side/src/presentation/constatns/exporter.dart';
// import 'package:resturant_side/src/presentation/screens/additems/additem.dart';

// typedef DoNothing = void Function();

// class ExpandableToggleTile extends StatefulWidget {
//   const ExpandableToggleTile({
//     Key? key,
//     required this.name,
//     required this.child,
//     required this.onChanged,
//   }) : super(key: key);
//   final String name;
//   final Widget child;
//   final VoidCallback onChanged;

//   @override
//   _ExpandableToggleTileState createState() => _ExpandableToggleTileState();
// }

// class _ExpandableToggleTileState extends State<ExpandableToggleTile> {
//   bool toShow = true;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 widget.name,
//                 style: FontStyleUtilities.h6(fontWeight: FWT.bold),
//               ),
//               const Spacer(),
//               SizedBox(
//                 width: 40,
//                 child: Switch(
//                     activeColor: ColorUtils.kcPrimary,
//                     value: toShow,
//                     onChanged: (val) {
//                       toShow = val;

//                       setState(() {});
//                     }),
//               )
//             ],
//           ),
//           const SizedBox(height: 6),
//           toShow ? widget.child : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
