import 'dart:convert';

import 'package:esyryt_final_app/json/getfilteredTodo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskHistory extends StatefulWidget {
  const TaskHistory({super.key});

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  String? selectedValue;

  // List<String> items = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  // ];

  List<GetTodoFiltered> todoList = [];

  Future<List<GetTodoFiltered>> getAllFilteredTodo() async {
    final Uri uri = Uri.parse(
        "https://notesapp-i6yf.onrender.com/user/todoTask/getFilteredToDo");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final Map<String, String> headers = {'x-auth-token': '$token'};
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> data =
          responseData['data']; // Assuming 'data' contains the list
      todoList = data.map((json) => GetTodoFiltered.fromJson(json)).toList();

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Success"),
      //   ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("${token}"),
      //   ),
      // );
      return todoList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed"),
        ),
      );
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool completed = false;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 82,
                  width: double.infinity,
                  color: Color(0xFF6C6C6C),
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 25, left: 25, top: 35, bottom: 13),
                    height: 38,
                    // color: Colors.red,
                    width: 375,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Builder(
                          builder: (BuildContext builderContext) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 19,
                                width: 23,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 100.0,
                          ),
                          child: Container(
                            height: 27,
                            width: 110,
                            // color: Colors.blue,
                            child: Center(
                              child: Image.asset(
                                'assets/TodoScreen1/Task History.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // height: 162,
                        // width: 359,
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          // color: Colors.red,
                          color: Color.fromARGB(255, 187, 184, 184),
                          // color: Color.fromARGB(255, 236, 233, 233),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 13.0, top: 15),
                              child: Container(
                                height: 15,
                                width: 188,
                                child: Text(
                                  "09/10/2023",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 13.0, top: 15, bottom: 12, right: 12),
                              child: FutureBuilder<List<GetTodoFiltered>>(
                                future: getAllFilteredTodo(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2));
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text("Error: ${snapshot.error}"));
                                  } else {
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final cover = snapshot.data![index];
                                        completed = cover.completed;

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 13, bottom: 3.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: 17,
                                                  width: 17,
                                                  child: Image.asset(
                                                    'assets/TodoScreen1/Group 214.png',
                                                  )),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                "${cover.title}", // work , personal ....
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                            //       Padding(
                            //         padding:
                            //             const EdgeInsets.only(left: 13.0, top: 15),
                            //         child: Row(
                            //           children: [
                            //             Container(
                            //               height: 14,
                            //               width: 14,
                            //               child: Image.asset(
                            //                 'assets/TodoScreen1/Group 214.png',
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               width: 8,
                            //             ),
                            //             Container(
                            //                 height: 20,
                            //                 child: Text(
                            //                   "Work On UI/UX For News App",
                            //                   style: TextStyle(
                            //                     fontSize: 14,
                            //                     fontWeight: FontWeight.w300,
                            //                   ),
                            //                 )),
                            //           ],
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //             const EdgeInsets.only(left: 13.0, top: 15),
                            //         child: Row(
                            //           children: [
                            //             Container(
                            //               height: 14,
                            //               width: 14,
                            //               child: Image.asset(
                            //                 'assets/TodoScreen1/Group 214.png',
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               width: 8,
                            //             ),
                            //             Container(
                            //                 height: 20,
                            //                 child: Text(
                            //                   "Work On UI/UX For News App",
                            //                   style: TextStyle(
                            //                     fontSize: 14,
                            //                     fontWeight: FontWeight.w300,
                            //                   ),
                            //                 )),
                            //           ],
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //             const EdgeInsets.only(left: 13.0, top: 15),
                            //         child: Row(
                            //           children: [
                            //             Container(
                            //               height: 14,
                            //               width: 14,
                            //               child: Image.asset(
                            //                 'assets/TodoScreen1/Group 214.png',
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               width: 8,
                            //             ),
                            //             Container(
                            //                 height: 20,
                            //                 child: Text(
                            //                   "Work On UI/UX For News App",
                            //                   style: TextStyle(
                            //                     fontSize: 14,
                            //                     fontWeight: FontWeight.w300,
                            //                   ),
                            //                 )),
                            //           ],
                            //         ),
                            //       ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 730,
              left: 45,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6C6C6C),
                  borderRadius: BorderRadius.circular(25),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black54,
                  //     offset: Offset(0, 1),
                  //     blurRadius: 6,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                width: 286,
                height: 40,
                child: Center(
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: SpeedDial(
        //   // closeManually: true,
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   child: Image.asset(
        //     'assets/TodoScreen1/Group 208.png',
        //   ),
        //   children: [
        //     SpeedDialChild(
        //       child: Image.asset("assets/1notescreen/textNote.png"),
        //       label: 'Text Note',
        //       backgroundColor: Color(0xff9D85DC),
        //       labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {
        //         // Handle the "Add" button click here
        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => NoteScreen2()));
        //       },
        //     ),
        //     SpeedDialChild(
        //       child: Image.asset("assets/1notescreen/attachment.png"),
        //       backgroundColor: Color(0xff9D85DC),
        //       label: 'Attachment',
        //       labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {
        //         // Handle the "Edit" button click here
        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => NoteScreen3()));
        //       },
        //     ),
        //     SpeedDialChild(
        //       child: Image.asset("assets/1notescreen/handwriting.png"),
        //       backgroundColor: Color(0xff9D85DC),
        //       label: 'Handwriting',
        //       labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {
        //         // Handle the "Edit" button click here
        //         // Navigator.push(context,
        //         // MaterialPageRoute(builder: (context) => NoteScreen4()));
        //       },
        //     ),
        //     SpeedDialChild(
        //       child: Image.asset("assets/1notescreen/audio.png"),
        //       backgroundColor: Color(0xff9D85DC),
        //       label: 'Audio',
        //       labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {
        //         // Handle the "Edit" button click here
        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => NoteScreen5()));
        //       },
        //     ),
        //     SpeedDialChild(
        //       child: Image.asset("assets/1notescreen/camera.png"),
        //       backgroundColor: Color(0xff9D85DC),
        //       label: 'Camera',
        //       labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {
        //         // Handle the "Edit" button click here
        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => NoteScreen6()));
        //       },
        //     ),
        //     // You can add more SpeedDialChild widgets for additional options
        //   ],
        // ),
      ),
    );
  }
}

CustomDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Color.fromARGB(255, 54, 53, 53),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
      ),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 176,
            width: 331,
            decoration: BoxDecoration(
              color: Color(0xFF6C6C6C),
              borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 1),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
          ),
          // SizedBox(height: 16.0),
          // Text(
          //   "John Doe",
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Text(
          //   "john.doe@email.com",
          //   style: TextStyle(
          //     fontSize: 16,
          //     color: Colors.grey,
          //   ),
          // ),
          // SizedBox(height: 16.0),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text("My Profile"),
          //   onTap: () {
          //     // Handle "My Profile" tap
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text("Settings"),
          //   onTap: () {
          //     // Handle "Settings" tap
          //   },
          // ),
        ],
      ),
    ),
  );
}
