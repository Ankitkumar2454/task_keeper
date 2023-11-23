// // ignore_for_file: unnecessary_null_comparison, null_check_always_fails

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:google_fonts/google_fonts.dart';

// class NoteScreen4 extends StatefulWidget {
//   const NoteScreen4({Key? key}) : super(key: key);

//   @override
//   _NoteScreen4State createState() => _NoteScreen4State();
// }

// class _NoteScreen4State extends State<NoteScreen4> {
//   // Flag to track whether the keyboard is open
//   bool isKeyboardOpen = false;
//   bool isDrawingMode = false;
//   bool isbold = false;
//   bool isitalic = false;
//   bool isunderline = false;
//   File? selectedImage;
//   String? selectedText;
//   int _selectedIndex = 0;
//   Color selectedColor = Colors.black;
//   double eraserSize = 20.0; // Default eraser size
//   double strokeWidth = 5;
//   bool isErasing = false;
//   void updateFontSize(double newSize) {
//     setState(() {
//       strokeWidth = newSize;
//     });
//   }

//   List<DrawingPoint> drawingPoints = [];
//   List<Color> colors = [
//     Color(0xffFF0101),
//     Color(0xff8FFF01),
//     Color(0xff05FFC3),
//     Color(0xff01D1FF),
//     Color(0xff9E01FF)
//   ];
//   Color selectedBackgroundColor = Color(0xFF9D85DC).withOpacity(0.6);

//   void openColorPicker(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Choose Background Color'),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//               pickerColor: selectedBackgroundColor,
//               onColorChanged: (color) {
//                 selectedBackgroundColor = color;
//               },
//               pickerAreaHeightPercent: 0.8,
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void openColorPickerForDraw(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Choose  Color'),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//               pickerColor: selectedColor,
//               onColorChanged: (color) {
//                 selectedColor = color; // Update the color here
//               },
//               pickerAreaHeightPercent: 0.8,
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void openPenOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Container(
//               height: 225,
//               child: Column(
//                 children: <Widget>[
//                   if (_selectedIndex != 2) // Show only when not in Eraser mode
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Row(
//                           children: List.generate(
//                             colors.length,
//                             (index) => _buildColorChose(colors[index]),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             openColorPickerForDraw(context);
//                           },
//                           child:
//                               Image.asset('assets/3notescreen/Group 305.png'),
//                         )
//                       ],
//                     ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 25),
//                     child: Row(
//                       children: [
//                         Text("Size:"),
//                         Container(
//                           width: 250,
//                           child: Slider(
//                             min: 0,
//                             max: 100,
//                             activeColor: _selectedIndex == 2
//                                 ? Colors.red
//                                 : Color(0xff9D85DC),
//                             value:
//                                 _selectedIndex == 2 ? eraserSize : strokeWidth,
//                             onChanged: (val) {
//                               setState(() {
//                                 if (_selectedIndex == 2) {
//                                   eraserSize =
//                                       val; // Set eraser size when in eraser mode
//                                 } else {
//                                   strokeWidth =
//                                       val; // Set stroke width when not in eraser mode
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         Container(
//                           width: 29,
//                           height: 20,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.4),
//                           ),
//                           child: Text(
//                             "${_selectedIndex == 2 ? eraserSize.toStringAsFixed(0) : strokeWidth.toStringAsFixed(0)}",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

// // Method to switch between drawing and eraser modes.
//   void toggleErasing() {
//     setState(() {
//       isErasing = !isErasing;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: InkWell(
//         onTap: () {},
//         child: Image.asset(
//           'assets/noteScreensAll/Group 208.png',
//         ),
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)
//             ]),
//         child: ClipRRect(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//           child: BottomNavigationBar(
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Image.asset('assets/3notescreen/Pen tool.png'),
//                 label: 'Pen',
//               ),
//               BottomNavigationBarItem(
//                 icon: Image.asset('assets/3notescreen/Group 290.png'),
//                 label: 'Background',
//               ),
//               BottomNavigationBarItem(
//                 icon: InkWell(
//                     onTap: () {
//                       setState(() {
//                         _selectedIndex = 2; // Select Eraser
//                         openPenOptions(context); // Open eraser size options
//                       });
//                     },
//                     child: Image.asset('assets/3notescreen/Eraser.png')),
//                 label: 'Eraser',
//               ),
//               BottomNavigationBarItem(
//                 icon: InkWell(
//                     onTap: () {
//                       // setState(() => drawingPoints = []);
//                     },
//                     child: Image.asset('assets/3notescreen/Clean.png')),
//                 label: 'All Clear',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: Color(0xFF6C6C6C),
//             unselectedItemColor: Colors.black45,
//             showSelectedLabels: true,
//             showUnselectedLabels: true,
//             onTap: (int index) {
//               setState(() {
//                 _selectedIndex = index;
//                 if (index == 0) {
//                   isDrawingMode = true;
//                   isErasing =
//                       false; // Disable eraser mode when switching to Pen mode
//                   openPenOptions(context);
//                 } else if (index == 2) {
//                   // Eraser
//                   toggleErasing(); // Toggle eraser mode
//                   if (isErasing) {
//                     selectedColor = selectedBackgroundColor.withOpacity(
//                         0.6); // Set erase color to background color
//                   }
//                 } else {
//                   isDrawingMode = false;
//                 }
//                 if (index == 1) {
//                   openColorPicker(context);
//                 }
//               });
//             },
//           ),
//         ),
//       ),
//       body: SafeArea(
//         top: true,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 82,
//                 color: Color(0xff6C6C6C),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(22, 0, 0, 0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           'assets/2notescreen/Group 276.png',
//                           width: 18,
//                           height: 12,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(36, 0, 0, 0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           'assets/3notescreen/Vector 9.png',
//                           width: 26,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(22, 0, 0, 0),
//                       child: Container(
//                         // color: Colors.red,
//                         // borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           'assets/3notescreen/Vector 8.png',
//                           width: 28,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(180, 0, 20, 0),
//                       child: GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             builder: (BuildContext context) => StatefulBuilder(
//                               builder: (BuildContext context,
//                                       StateSetter setState) =>
//                                   Container(
//                                 height: 250,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       height: 56,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff3b305a),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 10, left: 15),
//                                         child: Row(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   right: 10),
//                                               child: Image.asset(
//                                                 'assets/2notescreen/Group 283.png',
//                                                 width: 19,
//                                                 height: 19,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Share',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: const Color(0xffffffff),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 15, left: 15),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 10),
//                                             child: Image.asset(
//                                               'assets/2notescreen/Bookmark.png',
//                                               width: 19,
//                                               height: 19,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Save',
//                                             style: GoogleFonts.poppins(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                               color: const Color(0xff000000),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 15, left: 15),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 10),
//                                             child: Image.asset(
//                                               'assets/2notescreen/Notebook.png',
//                                               width: 19,
//                                               height: 19,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Find in Note',
//                                             style: GoogleFonts.poppins(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                               color: const Color(0xff000000),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 15, left: 15),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 10),
//                                             child: Image.asset(
//                                               'assets/2notescreen/Notification.png',
//                                               width: 19,
//                                               height: 19,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Add Reminder',
//                                             style: GoogleFonts.poppins(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                               color: const Color(0xff000000),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 15, left: 15),
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 10),
//                                             child: Image.asset(
//                                               'assets/2notescreen/Delete.png',
//                                               width: 19,
//                                               height: 19,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Move To Trash',
//                                             style: GoogleFonts.poppins(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                               color: const Color(0xff000000),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.asset(
//                             'assets/2notescreen/Group 275.png',
//                             width: 3,
//                             height: 14.5,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Align(
//                   child: Stack(
//                 children: [
//                   Container(
//                     width: 333,
//                     height: 500,
//                     decoration: BoxDecoration(color: selectedBackgroundColor),
//                     child: GestureDetector(
//                       onPanStart: (details) {
//                         setState(() {
//                           drawingPoints.add(
//                             DrawingPoint(
//                               details.localPosition,
//                               Paint()
//                                 ..color = selectedColor
//                                 ..isAntiAlias = true
//                                 ..strokeWidth = strokeWidth
//                                 ..strokeCap = StrokeCap.round,
//                             ),
//                           );
//                         });
//                       },
//                       onPanUpdate: (details) {
//                         setState(() {
//                           drawingPoints.add(
//                             DrawingPoint(
//                               details.localPosition,
//                               Paint()
//                                 ..color = selectedColor
//                                 ..isAntiAlias = true
//                                 ..strokeWidth = strokeWidth
//                                 ..strokeCap = StrokeCap.round,
//                             ),
//                           );
//                         });
//                       },
//                       onPanEnd: (details) {
//                         setState(() {
//                           if (drawingPoints != null) {
//                             drawingPoints.add(null!);
//                           }
//                         });
//                       },
//                       child: Container(
//                         width: 333,
//                         height: 500,
//                         child: CustomPaint(
//                           size: Size(333, 500),
//                           painter: _DrawingPainter(drawingPoints, eraserSize,
//                               selectedBackgroundColor, isErasing),
//                           child: Container(
//                             width: 333,
//                             height: 500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildColorChose(Color color) {
//     bool isSelected = selectedColor == color;
//     return Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: GestureDetector(
//         onTap: () => setState(() => selectedColor = color),
//         child: Container(
//           height: isSelected ? 47 : 40,
//           width: isSelected ? 47 : 40,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             border:
//                 isSelected ? Border.all(color: Colors.white, width: 3) : null,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DrawingPainter extends CustomPainter {
//   final List<DrawingPoint> drawingPoints;
//   final double eraserSize;
//   final Color selectedBackgroundColor;
//   final bool isErasing;
//   _DrawingPainter(this.drawingPoints, this.eraserSize,
//       this.selectedBackgroundColor, this.isErasing);

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (int i = 0; i < drawingPoints.length - 1; i++) {
//       if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
//         if (!isErasing) {
//           // Only draw when not in eraser mode.
//           canvas.drawLine(
//             drawingPoints[i].offset,
//             drawingPoints[i + 1].offset,
//             drawingPoints[i].paint,
//           );
//         }
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// class DrawingPoint {
//   Offset offset;
//   Paint paint;

//   DrawingPoint(this.offset, this.paint);
// }
