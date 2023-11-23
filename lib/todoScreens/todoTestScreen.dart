// import 'dart:convert';

// import 'package:esyryt_final_app/authentications/profilePage.dart';
// import 'package:esyryt_final_app/helper/dropDown.dart';
// import 'package:esyryt_final_app/json/getAllCategory.dart';
// import 'package:esyryt_final_app/json/getfilteredTodo.dart';
// import 'package:esyryt_final_app/services/client.dart';
// import 'package:esyryt_final_app/testing.dart';
// import 'package:esyryt_final_app/todoScreens/categoryDropDown.dart';
// import 'package:esyryt_final_app/todoScreens/dateDropDown.dart';
// import 'package:esyryt_final_app/todoScreens/priorityDropDown.dart';
// import 'package:esyryt_final_app/todoScreens/taskHistory.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class TodoTest extends StatefulWidget {
//   const TodoTest({super.key});

//   @override
//   State<TodoTest> createState() => _TodoTestState();
// }

// class _TodoTestState extends State<TodoTest> {
//   String? selectedValue;
//   // bool isKeyboardOpen = false;

//   // final GlobalKey dropdownKey = GlobalKey();

//   void _showBottomSheet() {
//     TextEditingController titleController = TextEditingController();
//     TextEditingController descriptionController = TextEditingController();
//     var dataModel = Provider.of<AuthClient>(context, listen: false);

//     // print("object hii ${dataModel.category}");
//     showModalBottomSheet(
//       isScrollControlled: true,
//       isDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         final MediaQueryData mediaQueryData = MediaQuery.of(context);
//         return Padding(
//           padding: mediaQueryData.viewInsets,
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Container(
//               margin: EdgeInsets.all(8.0),
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 40,
//                       width: 323,
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 228, 225, 225),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 5.0, left: 9),
//                         child: TextField(
//                           controller: titleController,
//                           // focusNode: textfieldFocusNode,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "What Would You Like To Do?",
//                             hintStyle: TextStyle(
//                               fontWeight: FontWeight.w300,
//                               fontSize: 13,
//                               color: Color.fromARGB(255, 101, 99, 99),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       height: 70,
//                       width: 323,
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 228, 225, 225),
//                         borderRadius: BorderRadius.circular(5),
//                         // color: Color.fromARGB(255, 236, 233, 233),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 4.0, left: 9),
//                         child: TextField(
//                           controller: descriptionController,
//                           // focusNode: textfieldFocusNode,
//                           maxLines: 3,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Description",
//                             hintStyle: TextStyle(
//                               fontWeight: FontWeight.w300,
//                               fontSize: 13,
//                               color: Color.fromARGB(255, 101, 99, 99),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 95,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 173, 180, 179),
//                               borderRadius: BorderRadius.circular(13.0),
//                             ),
//                             child: CategoryDropDown(
//                               text: "Category",
//                               // checkDrop: checkDrop,
//                             )),
//                         SizedBox(
//                           width: 12,
//                         ),
//                         Container(
//                           width: 80,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF6C6C6C),
//                             borderRadius: BorderRadius.circular(13.0),
//                           ),
//                           child: DateDropDown(
//                             text: "Date",
//                           ),
//                         ),
//                         SizedBox(
//                           width: 12,
//                         ),
//                         Container(
//                           width: 88,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 200, 197, 197),
//                             borderRadius: BorderRadius.circular(13.0),
//                           ),
//                           child: PriorityDropDown(
//                             text: "priority",
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 12,
//                         ),
//                         Container(
//                           width: 110,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 200, 197, 197),
//                             borderRadius: BorderRadius.circular(13.0),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Reminder",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 18,
//                         ),
//                         Container(
//                           width: 71,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 200, 197, 197),
//                             borderRadius: BorderRadius.circular(13.0),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Emoji",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: InkWell(
//                         onTap: () {
//                           print("valuee is ");
//                           print(CategoryDropDown.categoryCheck);
//                           if (CategoryDropDown.categoryCheck == false &&
//                               PriorityDropDown.priorityCheck == false &&
//                               DateDropDown.dateCheck == false) {
//                             if (titleController.text.trim().isEmpty) {
//                               Navigator.pop(context);
//                             } else {
//                               print("nothing doing");
//                               Navigator.pop(context);
//                             }
//                           }
//                         },
//                         child: Container(
//                           // color: Colors.red,
//                           height: 63,
//                           width: 63,
//                           child: Image.asset(
//                             'assets/TodoScreen1/Group 237.png',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool completed = false;
//     return SafeArea(
//       child: Scaffold(
//         // drawer: CustomDrawer(context),
//         // drawer: CustomDrawer(context, profilepic, profilepicUrl, name, email),
//         body: Stack(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   height: 82,
//                   width: double.infinity,
//                   color: Color(0xFF6C6C6C),
//                   child: Container(
//                     padding: EdgeInsets.only(
//                         right: 25, left: 25, top: 35, bottom: 13),
//                     height: 38,
//                     // color: Colors.red,
//                     // width: 375,
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Builder(
//                           builder: (BuildContext builderContext) {
//                             return InkWell(
//                               onTap: () {
//                                 Scaffold.of(builderContext).openDrawer();
//                               },
//                               child: Container(
//                                 height: 19,
//                                 width: 23,
//                                 child: Image.asset(
//                                   'assets/todo/Group 388.png',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         SizedBox(
//                           width: 43,
//                         ),
//                         Container(
//                           height: 30,
//                           width: 140,
//                           // color: Colors.blue,
//                           child: CustomDropdown(
//                             text: "hello",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(13.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             completed = !completed;
//                           });
//                         },
//                         child: Container(
//                           height: 300,
//                           width: 400,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25),
//                             color: Color.fromARGB(255, 187, 184, 184),
//                           ),
//                           child: ListTile(
//                             leading: Container(
//                               height: 17,
//                               width: 17,
//                               child: Image.asset(
//                                 'assets/TodoScreen1/Ellipse 77.png',
//                               ),
//                             ),
//                             title: Text(
//                               "${"title"}", // work , personal ....
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               top: 700,
//               left: 29,
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaskHistory(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 100,
//                   height: 20,
//                   child: Text(
//                     "Task History",
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _showBottomSheet();
//             });
//           },
//           backgroundColor: Colors.white,
//           elevation: 0,
//           child: Image.asset(
//             'assets/TodoScreen1/Group 208.png',
//           ),
//         ),
//       ),
//     );
//   }
// }

// CustomDrawer(context, var profilepic, var profilepicUrl, var name, var email) {
//   return Drawer(
//     backgroundColor: Color.fromARGB(255, 54, 53, 53),
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             height: 176,
//             width: 331,
//             decoration: BoxDecoration(
//               color: Color(0xFF6C6C6C),
//               borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black54,
//                   offset: Offset(0, 1),
//                   blurRadius: 6,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 90,
//             left: 20,
//             child: CircleAvatar(
//               backgroundColor: Colors.grey,
//               radius: 80,
//               child: (profilepicUrl != null)
//                   ? ClipOval(
//                       child: Image.network(
//                         profilepicUrl,
//                         fit: BoxFit.cover,
//                         height: 158,
//                         width: 160,
//                       ),
//                     )
//                   : Icon(
//                       Icons.person,
//                       size: 50,
//                     ),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Positioned(
//             top: 260,
//             left: 10,
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ProfilePage(
//                               imageUrl: profilepicUrl,
//                               name: name,
//                             )));
//               },
//               child: Container(
//                 width: 250,
//                 color: Colors.blue,
//                 child: ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text("My Profile"),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Positioned(
//             top: 340,
//             left: 50,
//             child: Text(
//               "Name : $name",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 380,
//             left: 50,
//             child: Text(
//               "Email : $email",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 600,
//             left: 10,
//             child: Container(
//               width: 250,
//               color: Colors.red,
//               child: ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text("Settings"),
//                 onTap: () {
//                   // Handle "Settings" tap
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
