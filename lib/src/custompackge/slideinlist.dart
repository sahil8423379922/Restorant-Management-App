// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:resturant_side/src/presentation/constatns/exporter.dart';

// class MyTile extends StatefulWidget {
//   const MyTile({Key? key, required this.controller, required this.index})
//       : super(key: key);
//   final ScrollController controller;
//   final int index;

//   @override
//   State<MyTile> createState() => _MyTileState();
// }

// class _MyTileState extends State<MyTile> {
//   late ValueNotifier animtaion;
//   @override
//   void initState() {
//     animtaion = ValueNotifier(0)
//       ..addListener(() {
//         print(animtaion.value);
//         setState(() {});
//       });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceHeight = MediaQuery.of(context).size.height;
//     final deviceWidth = MediaQuery.of(context).size.width;
//     ValueNotifier<double> yCoordinate = ValueNotifier<double>(0);
//     WidgetsBinding.instance?.addPostFrameCallback((t) {
//       RenderBox box = context.findRenderObject() as RenderBox;
//       animtaion.value = box.localToGlobal(Offset.zero);
//       yCoordinate.value = (box.localToGlobal(Offset.zero).dy +
//               deviceHeight / 2 -
//               (deviceHeight + 40)) /
//           490;
//       print(
//           "at ${widget.index} indexed position ${-yCoordinate.value.clamp(-1, 0)}");
//     });

//     return AnimatedBuilder(
//       animation: yCoordinate,
//       builder: (context, _) => Transform(
//         transform: Matrix4.identity()
//           ..translate(-(yCoordinate.value.clamp(-1, 0)) * deviceWidth),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadiusDirectional.circular(15),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   offset: const Offset(4, 5),
//                   color: Colors.transparent.withOpacity(.13),
//                   blurRadius: 20),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Customer Number ${widget.index}',
//                 style: FontStyleUtilities.h4(fontWeight: FWT.medium),
//               )
//             ],
//           ),
//           height: 100,
//           padding: const EdgeInsets.all(16),
//           margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//         ),
//       ),
//     );
//   }
// }

// class TrimerList extends StatefulWidget {
//   const TrimerList({Key? key}) : super(key: key);

//   @override
//   State<TrimerList> createState() => _TrimerListState();
// }

// class _TrimerListState extends State<TrimerList> {
//   late ScrollController _controller;
//   @override
//   void initState() {
//     _controller = ScrollController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, _) => ListView.builder(
//             controller: _controller,
//             itemCount: 100,
//             shrinkWrap: true,
//             itemBuilder: (context, i) => MyTile(
//               controller: _controller,
//               index: i,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
