// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:esyryt_final_app/homePage.dart';
import 'package:esyryt_final_app/services/client.dart';
import 'package:esyryt_final_app/todoScreens/todoScreen1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleTaskReader extends StatefulWidget {
  String id;

  // in this page there is only one id

  SingleTaskReader({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  State<SingleTaskReader> createState() => _SingleTaskReaderState();
}

class _SingleTaskReaderState extends State<SingleTaskReader> {
  var title;
  var description;
  void getSingleTaskDetails(String _id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      // the response we are getting is a response.body
      var response = await AuthClient()
          .getSingleTask('/user/todoTask/getSingleTask/$_id', token!);
      setState(() {
        var value = jsonDecode(response);
        var dataResponse = value;
        print("single task values");
        print(dataResponse);
        title = dataResponse['task']['title'];

        print(title);
        description = dataResponse['task']['description'];
        print(description);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void DeleteSingleTaskDetails(String _id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      // the response we are getting is a response.body
      var response = await AuthClient()
          .DeleteSingleTask('/user/todoTask/deleteTask/$_id', token!);
      setState(() {
        var value = jsonDecode(response);
        var dataResponse = value;
        print("delete task values");
        print(dataResponse);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    var _id = widget.id;
    getSingleTaskDetails(_id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _id = widget.id;
    print("here reacged id == $_id");

    var date = DateTime.now();
    var formattedDate = DateFormat('d MMM, yyyy').format(date).toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 82,
                color: Color(0xff6C6C6C),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: Container(
                            width: 23,
                            height: 12,
                            child: Icon(Icons.arrow_back_ios,
                                color: Colors.white)),
                      ),
                    ),
                    // Text(
                    //   'Detailed Single Task',
                    //   style: GoogleFonts.poppins(
                    //     color: Colors.white,
                    //     fontSize: 19,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(8),
                    //     child: Image.asset(
                    //       'assets/1notescreen/Group 263.png',
                    //       width: 21,
                    //       height: 21,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$formattedDate",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  height: 34,
                  width: double.infinity,
                  // color: Colors.red,
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    "${title}",
                    // 'title here',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  height: 143,
                  width: 330,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        left: 294,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff6C6C6C),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "${title}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              height: 23,
                              width: 117,
                              // color: Colors.purple,
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                "${description}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  size: 15,
                                  color: Color.fromARGB(255, 59, 58, 58),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Pending",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 120, 119, 119),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "6:53 Pm",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff6C6C6C),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(8))),
                              // height: double.maxFinite,
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.notifications_active,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "Reminder",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),

        //delete task
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              DeleteSingleTaskDetails(_id);
              // Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    child: HomePage(),
                    type: PageTransitionType.fade,
                    isIos: true,
                    duration: Duration(milliseconds: 900),
                  ),
                  (route) => false);
            });
          },
          child: Icon(Icons.delete_forever),
        ),
      ),
    );
  }
}
