// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:esyryt_final_app/services/client.dart';
// import "package:flutter/material.dart";
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';

// import 'package:esyryt_final_app/helper/dropDown.dart';

// class PriorityDropDown extends StatefulWidget {
//   final String text;

//   static bool priorityCheck = false;

//   PriorityDropDown({
//     Key? key,
//     required this.text,
//   }) : super(key: key);
//   @override
//   State<PriorityDropDown> createState() => _PriorityDropDownState();
// }

// class _PriorityDropDownState extends State<PriorityDropDown> {
//   late GlobalKey actionPriorityKey;
//   late double pheight, pwidth, pxPosition, pyPosition;
//   bool isDropdownPriorityOpened = false;
//   late OverlayEntry floatingPriorityDropdown;

//   @override
//   void initState() {
//     super.initState();
//     actionPriorityKey = LabeledGlobalKey(widget.text);
//     isDropdownPriorityOpened = false;
//     floatingPriorityDropdown = _createFloatingPriorityDropdown();
//   }

//   void findPriorityDropdownData() {
//     RenderBox? renderBox =
//         actionPriorityKey.currentContext?.findRenderObject() as RenderBox?;
//     // RenderObject? renderBox =actionKey.currentContext?.findRenderObject();
//     if (renderBox != null) {
//       pheight = renderBox.size.height;
//       pwidth = renderBox.size.width;
//       Offset offset = renderBox.localToGlobal(Offset.zero);
//       pxPosition = offset.dx;
//       pyPosition = offset.dy;
//       // print(pheight);
//       // print(pwidth);
//       // print(pxPosition);
//       // print(pyPosition);
//     } else {
//       // Handle the case where renderBox is not a RenderBox
//     }
//   }

//   OverlayEntry _createFloatingPriorityDropdown() {
//     return OverlayEntry(builder: (context) {
//       return Positioned(
//         right: 27,
//         width: pwidth * 1.3,
//         top: 550,
//         height: 130,
//         child: DropDownPriority(
//           itemHeight: pheight,
//         ),
//       );
//     });
//   }

//   TextEditingController dateController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     AuthClient authClient = Provider.of<AuthClient>(context, listen: false);
//     return GestureDetector(
//       key: actionPriorityKey,
//       onTap: () {
//         setState(() {
//           if (isDropdownPriorityOpened) {
//             // print(widget.checkDrop);
//             PriorityDropDown.priorityCheck = false;
//             floatingPriorityDropdown.remove();
//           } else {
//             findPriorityDropdownData();
//             floatingPriorityDropdown = _createFloatingPriorityDropdown();
//             Overlay.of(context).insert(floatingPriorityDropdown);
//           }
//           isDropdownPriorityOpened = !isDropdownPriorityOpened;
//           authClient.dropDownPriorityCheck(isDropdownPriorityOpened);
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Color.fromARGB(255, 200, 197, 197),
//           // color: Color.fromARGB(255, 233, 10, 10),
//         ),
//         // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Text(
//                 widget.text,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DropDownPriority extends StatefulWidget {
//   final double itemHeight;

//   DropDownPriority({super.key, required this.itemHeight});

//   @override
//   State<DropDownPriority> createState() => _DropDownPriorityState();
// }

// class _DropDownPriorityState extends State<DropDownPriority> {
//   // TextEditingController dateController = TextEditingController();
//   // @override
//   // void initState() {
//   //   dateController.text = "";
//   // }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.itemHeight * 4.6);
//     return Container(
//       // color: Colors.pink,
//       height: 105,
//       width: double.maxFinite,
//       child: Column(
//         children: <Widget>[
//           Material(
//             elevation: 23,
//             shape: ArrowShape(),
//             child: Container(
//               height: 3.7 * widget.itemHeight,
//               decoration: BoxDecoration(
//                   // color: Colors.green,
//                   // borderRadius: BorderRadius.circular(15),
//                   ),
//               child: Column(
//                 children: <Widget>[
//                   DropDownPriorityItem(
//                     text: "Default",
//                     iconData: Icons.bookmark,
//                     isSelected: false,
//                     color: Colors.red,
//                   ),
//                   DropDownPriorityItem(
//                     text: "High",
//                     iconData: Icons.bookmark,
//                     isSelected: false,
//                     color: Colors.yellow,
//                   ),
//                   DropDownPriorityItem(
//                     text: "Low",
//                     iconData: Icons.bookmark,
//                     isSelected: false,
//                     color: Colors.blue,
//                   ),
//                   // DropDownItem(
//                   //   text: "Priority 4",
//                   //   iconData: Icons.bookmark,
//                   //   color: Colors.white38,
//                   //   isSelected: false,
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 3,
//           ),
//           Align(
//             alignment: Alignment(0.2, 0),
//             child: ClipPath(
//               clipper: ArrowPriorityClipper(),
//               child: Container(
//                 height: 13,
//                 width: 13,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 60, 59, 59),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DropDownPriorityItem extends StatelessWidget {
//   final String text;
//   final IconData? iconData;
//   final bool isSelected;
//   final bool isFirstItem;
//   final bool isLastItem;
//   final Color? color;

//   const DropDownPriorityItem(
//       {Key? key,
//       required this.text,
//       this.iconData,
//       this.color,
//       this.isSelected = false,
//       this.isFirstItem = false,
//       this.isLastItem = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         // width: 150,
//         decoration: BoxDecoration(
//           // color: Colors.purple,
//           borderRadius: BorderRadius.vertical(
//             top: isFirstItem ? Radius.circular(8) : Radius.zero,
//             bottom: isLastItem ? Radius.circular(8) : Radius.zero,
//           ),
//           color: isSelected
//               ? Colors.red.shade900
//               : Color(0xFF6C6C6C).withOpacity(0.7),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//         child: Row(
//           children: <Widget>[
//             Icon(
//               iconData,
//               color: color,
//             ),
//             Text(
//               text,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             // Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ArrowPriorityClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();

//     // path.moveTo(0, size.height);
//     // path.lineTo(size.width / 2, 0);
//     // path.lineTo(size.width, size.height);
//     path.moveTo(0, 0); // Start from the top-left corner
//     path.lineTo(size.width, 0); // Draw a line to the top-right corner
//     path.lineTo(
//         size.width / 2, size.height); // Draw a line to the bottom-center
//     path.close(); // Close the path to form a triangular shape

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

// // class ArrowShape extends ShapeBorder {
// //   @override
// //   // TODO: implement dimensions
// //   EdgeInsetsGeometry get dimensions => throw UnimplementedError();

// //   @override
// //   Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
// //     // TODO: implement getInnerPath
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
// //     // TODO: implement getOuterPath
// //     return getClip(rect.size);
// //   }

// //   @override
// //   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
// //     // TODO: implement paint
// //   }

// //   @override
// //   ShapeBorder scale(double t) {
// //     // TODO: implement scale
// //     throw UnimplementedError();
// //   }

// //   Path getClip(Size size) {
// //     Path path = Path();

// //     // path.moveTo(0, size.height);
// //     // path.lineTo(size.width / 2, 0);
// //     // path.lineTo(size.width, size.height);

// //     return path;
// //   }
// // }
