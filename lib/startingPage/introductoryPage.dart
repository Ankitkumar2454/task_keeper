// import 'package:flutter/material.dart';

// class IntroductoryPage extends StatelessWidget {
//   const IntroductoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: Colors.grey,
//         body: Stack(
//           children: [
//             Positioned(
//               top: -1,
//               child: Container(
//                 // color: Colors.red,
//                 height: 131,
//                 width: 129,
//                 child: Image.asset(
//                   'assets/introductory/Group 420.png',
//                   // color: Color(0xFF6C6C6C),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 721,
//               left: -26,
//               child: Container(
//                 // color: Colors.red,
//                 height: 82,
//                 width: 83,
//                 child: Image.asset(
//                   'assets/introductory/Group 417.png',
//                   color: Color(0xFF6C6C6C),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 73,
//               left: 211,
//               child: Column(
//                 children: [
//                   Container(
//                     // color: Colors.red,
//                     height: 74,
//                     width: 88,
//                     child: Image.asset(
//                       'assets/introductory/options-lines.png',
//                       color: Color(0xFF6C6C6C),
//                     ),
//                   ),
//                   Container(
//                     height: 18,
//                     width: 64,
//                     child: Center(
//                       child: Text(
//                         "categories",
//                         style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 172,
//               left: 249,
//               child: Container(
//                 height: 4,
//                 width: 4,
//                 child: Image.asset(
//                   'assets/introductory/Ellipse 107.png',
//                   color: Color(0xFF6C6C6C),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 146,
//               left: 97,
//               child: Column(
//                 children: [
//                   Container(
//                     // color: Colors.red,
//                     height: 61,
//                     width: 73,
//                     child: Image.asset(
//                       'assets/introductory/calendar.png',
//                       color: Color(0xFF6C6C6C),
//                     ),
//                   ),
//                   Container(
//                     height: 18,
//                     width: 64,
//                     child: Center(
//                       child: Text(
//                         "Date",
//                         style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 11,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 228,
//               left: 142,
//               child: Container(
//                 height: 4,
//                 width: 4,
//                 child: Image.asset(
//                   'assets/introductory/Ellipse 107.png',
//                   color: Color(0xFF6C6C6C),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 285,
//               left: 18,
//               child: Column(
//                 children: [
//                   Center(
//                     child: Container(
//                       height: 80,
//                       width: 94,
//                       child: Image.asset(
//                         'assets/introductory/prioritize.png',
//                         color: Color(0xFF6C6C6C),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 18,
//                     width: 64,
//                     child: Center(
//                       child: Text(
//                         "priority",
//                         style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 317,
//               left: 113,
//               child: Container(
//                 height: 4,
//                 width: 4,
//                 child: Image.asset(
//                   'assets/introductory/Ellipse 107.png',
//                   color: Color(0xFF6C6C6C),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 462,
//               left: 47,
//               child: Column(
//                 children: [
//                   Container(
//                     // color: Colors.red,
//                     height: 105,
//                     width: 124,
//                     child: Image.asset(
//                       'assets/introductory/bell.png',
//                       color: Color(0xFF6C6C6C),
//                     ),
//                   ),
//                   Container(
//                     height: 18,
//                     width: 58,
//                     child: Center(
//                       child: Text(
//                         "Reminder",
//                         style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 455,
//               left: 138,
//               child: Container(
//                 height: 4,
//                 width: 4,
//                 child: Image.asset(
//                   'assets/introductory/Ellipse 107.png',
//                   color: Color(0xFF6C6C6C),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 450,
//               left: 282,
//               child: Container(
//                 height: 4,
//                 color: Colors.red,
//                 width: 4,
//                 child: Image.asset(
//                   'assets/introductory/Ellipse 107.png',
//                   color: Color(0xFF6C6C6C),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 460,
//               left: 250,
//               child: Column(
//                 children: [
//                   Container(
//                     // color: Colors.red,
//                     height: 53,
//                     width: 63,
//                     child: Image.asset(
//                       'assets/introductory/laugh.png',
//                       color: Color(0xFF6C6C6C),
//                     ),
//                   ),
//                   Container(
//                     height: 18,
//                     width: 64,
//                     child: Center(
//                       child: Text(
//                         "Emoji",
//                         style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 197,
//               left: 168,
//               child: Column(
//                 children: [
//                   Container(
//                     // color: Colors.red,
//                     height: 249,
//                     width: 190,
//                     child: Image.asset(
//                       'assets/introductory/Group 262.png',
//                       // color: Color(0xFF6C6C6C),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 670,
//               left: 169,
//               child: Column(
//                 children: [
//                   Container(
//                     height: 20,
//                     width: 41,
//                     child: Image.asset(
//                       'assets/introTodo/ToDo.png',
//                       color: Color(0xFF6C6C6C),
//                     ),
//                   ),
//                   Container(
//                     // color: Colors.red,
//                     height: 6,
//                     width: 65,
//                     child: Image.asset(
//                       'assets/introductory/Group 6.png',
//                       color: Color(0xFF6C6C6C),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 674,
//               left: 284,
//               child: Container(
//                 // color: Colors.red,
//                 height: 180,
//                 width: 181,
//                 child: Image.asset(
//                   'assets/introductory/Group 420.png',
//                   // color: Color.fromARGB(255, 240, 236, 236),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
