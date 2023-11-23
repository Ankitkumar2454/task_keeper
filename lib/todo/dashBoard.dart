// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:esyryt_final_app/authentications/profilePage.dart';
import 'package:esyryt_final_app/services/client.dart';
import 'package:esyryt_final_app/todo/noteEditor.dart';
import 'package:esyryt_final_app/todo/noteReader.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var value, title, description, createdDateTime;
  var totalDataCount;
  Future<List<dynamic>?> fetchData() async {
    var client = http.Client();
    var response;
    try {
      var url =
          Uri.parse('https://notesapp-i6yf.onrender.com/user/getAllNotes');
      response = await client.get(url);
      print(response.body);
      setState(() {
        value = jsonDecode(response.body);
        totalDataCount = value['data'].length;
        print(totalDataCount);
      });
    } catch (e) {
      print(e);
    }
    if (response == null) {
      print('No response received');
    } else if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      return null;
    }
  }

  var status;
  var profilepic;
  String? profilepicUrl;
  String? name;
  var email;

  void getProfileDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      // the response we are getting is a response.body
      var response = await context
          .read<AuthClient>()
          .getProfile('/user/auth/getProfile', token!);
      setState(() {
        var value = jsonDecode(response);
        var dataResponse = value;
        print("picvalues");
        print(dataResponse);
        status = dataResponse["message"];
        profilepic = dataResponse["data"]["profilePic"]["filename"];
        profilepicUrl = dataResponse["data"]["profilePic"]["url"];
        name = dataResponse["data"]["name"];
        email = dataResponse["data"]["email"];
      });
      // var status = dataResponse["message"];
      print(status);
      print(profilepic);
      print(profilepicUrl);
      print(name);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    setState(() {
      getProfileDetails();
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(value);

    String formatTimeAgo(String dateTimeString) {
      final dateTime = DateTime.parse(dateTimeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} min ago';
      } else {
        return 'Just now';
      }
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(context, profilepic, profilepicUrl, name, email),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 97,
              // width: 375,
              color: Color(0xFF6C6C6C),
              child: Container(
                padding: EdgeInsets.only(right: 25, left: 25, top: 35),
                height: 38,
                // width: 375,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (BuildContext builderContext) {
                        return InkWell(
                          onTap: () {
                            Scaffold.of(builderContext).openDrawer();
                          },
                          child: Container(
                            child: Image.asset(
                              'assets/todo/Group 388.png',
                              height: 19,
                              width: 23,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 39,
                    ),
                    Container(
                      height: 34,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(25),
                        // color: Color.fromARGB(255, 236, 233, 233),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0),
                            child: Container(
                              // color: Colors.green,
                              height: 29,
                              width: 25,
                              child: Icon(
                                Icons.search,
                                color: Color(0x456C6C6C),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Container(
                            // color: Colors.green,
                            height: 20,
                            width: 50,
                            child: Center(
                              child: Text(
                                "Search",
                                style: TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 15,
                                  color: Color(0x456C6C6C),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // HeaderWidget(),
            NotesContainerData(formatTimeAgo, "To Do "),
            NotesContainerData(formatTimeAgo, "Notes"),
            NotesContainerData(formatTimeAgo, "Diary"),
          ],
        )),
      ),
    );
  }

  Column NotesContainerData(
      String formatTimeAgo(String dateTimeString), String taskName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 26,
          width: 49,
          child: Center(
            child: Text(
              "$taskName",
              style: TextStyle(
                fontSize: 17,
                color: Color(0xff000000),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 200,
          child: (value != null)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalDataCount,
                  itemBuilder: (context, index) {
                    // print(value["data"][0]["title"]);
                    // var title = value["data"][0]["title"];
                    title = value["data"][index]["title"];
                    description = value["data"][index]["description"];
                    createdDateTime =
                        value["data"][index]["createdAt"].toString();
                    final parsedDate = DateTime.parse(createdDateTime);
                    final formattedDate =
                        DateFormat('d MMM, y').format(parsedDate);

                    final now = DateTime.now();
                    final difference = now.difference(parsedDate);

                    final formattedTimeAgo = formatTimeAgo(createdDateTime);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteReaderScreen(
                                  title: title,
                                  description: description,
                                  formattedDate: formattedDate)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 172,
                          width: 119,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 2,
                                // spreadRadius: 2,
                              ),
                            ],
                            border: Border.all(width: 0, color: Colors.grey),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 20,
                                  width: 84,
                                  child: Text(
                                    "Things To Do",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "$title",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "$description",
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 10,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF6C6C6C),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(22)),
                                  ),
                                  height: 35,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
                                          // color: Colors.black87,
                                          height: 15,
                                          width: 75,
                                          child: Center(
                                            child: Text(
                                              "$formattedTimeAgo",
                                              style: TextStyle(
                                                overflow: TextOverflow.clip,
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Container(
                                            height: 20,
                                            width: 16,
                                            child: Center(
                                                child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 16,
                                            ))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
        ),
      ],
    );
  }
}

CustomDrawer(context, var profilepic, var profilepicUrl, var name, var email) {
  return Drawer(
    backgroundColor: Color.fromARGB(255, 54, 53, 53),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
      ),
      child: Stack(
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
            top: 90,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 80,
              child: (profilepicUrl != null)
                  ? ClipOval(
                      child: Image.network(
                        profilepicUrl,
                        fit: BoxFit.cover,
                        height: 158,
                        width: 160,
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 50,
                    ),
            ),
          ),
          SizedBox(height: 16.0),
          Positioned(
            top: 260,
            left: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              imageUrl: profilepicUrl,
                              name: name,
                            )));
              },
              child: Container(
                width: 250,
                color: Colors.blue,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("My Profile"),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Positioned(
            top: 340,
            left: 50,
            child: Text(
              "Name : $name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 380,
            left: 50,
            child: Text(
              "Email : $email",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Positioned(
            top: 600,
            left: 10,
            child: Container(
              width: 250,
              color: Colors.red,
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  // Handle "Settings" tap
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 82,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9D85DC), Color(0xFF3B305A)],
          stops: [0.1, 0.9],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/2notescreen/Group 276.png',
                width: 18,
                height: 12,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/2notescreen/Vector 9.png',
              width: 26,
              fit: BoxFit.cover,
            ),
          ),
          InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/2notescreen/Vector 8.png',
                width: 26,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/2notescreen/Group 277.png',
                width: 79,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) =>
                        Container(
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Color(0xff3b305a),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'assets/2notescreen/Group 283.png',
                                      width: 19,
                                      height: 19,
                                    ),
                                  ),
                                  Text(
                                    'Share',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Bookmark.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Save',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Notebook.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Find in Note',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Notification.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Add Reminder',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Delete.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Move To Trash',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/2notescreen/Group 275.png',
                  width: 6,
                  height: 22.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("johndoe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/profile_picture.jpg'), // Add your profile picture image here
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Add your logic for item 1 here
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Add your logic for item 2 here
            },
          ),
          // Add more menu items as needed
        ],
      ),
    );
  }
}
