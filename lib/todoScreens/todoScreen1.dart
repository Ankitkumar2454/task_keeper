import 'dart:convert';

import 'package:esyryt_final_app/authentications/profilePage.dart';
import 'package:esyryt_final_app/helper/dropDown.dart';
import 'package:esyryt_final_app/homePage.dart';
import 'package:esyryt_final_app/json/getAllCategory.dart';
import 'package:esyryt_final_app/json/getfilteredTodo.dart';
import 'package:esyryt_final_app/services/client.dart';
import 'package:esyryt_final_app/testing.dart';
import 'package:esyryt_final_app/todo/noteEditor.dart';
import 'package:esyryt_final_app/todo/noteReader.dart';
import 'package:esyryt_final_app/todoScreens/categoryDropDown.dart';
import 'package:esyryt_final_app/todoScreens/dateDropDown.dart';
import 'package:esyryt_final_app/todoScreens/priorityDropDown.dart';
import 'package:esyryt_final_app/todoScreens/reminderDropDown.dart';
import 'package:esyryt_final_app/todoScreens/singleTaskReader.dart';
import 'package:esyryt_final_app/todoScreens/taskHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodoScreen1 extends StatefulWidget {
  const TodoScreen1({super.key});

  @override
  State<TodoScreen1> createState() => _TodoScreen1State();
}

class _TodoScreen1State extends State<TodoScreen1> {
  String? selectedValue;
  // bool isKeyboardOpen = false;

  final GlobalKey dropdownKey = GlobalKey();

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
    getProfileDetails();
  }

  List<GetTodoFiltered> todoList = [];

// here only get todoList

  var _id, value;
  Future<List<GetTodoFiltered>> getAllFilteredTodo() async {
    final Uri uri = Uri.parse(
        "https://notesapp-i6yf.onrender.com/user/todoTask/getFilteredToDo");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final Map<String, String> headers = {'x-auth-token': '$token'};
    final response = await http.get(uri, headers: headers);
    print("getAllFilteredTodo");

    print(response.body);
    value = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> data = responseData['data'];
      todoList = data.map((json) => GetTodoFiltered.fromJson(json)).toList();

      return todoList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "No task found",
          ),
        ),
      );

      // throw Exception('Failed to load data');
      return todoList;
    }
  }

  void _showBottomSheet() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    var dataModel = Provider.of<AuthClient>(context, listen: false);

    // print("object hii ${dataModel.category}");
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        return Padding(
          padding: mediaQueryData.viewInsets,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Consumer<AuthClient>(builder: (context, authClient, child) {
              return Container(
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 323,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 228, 225, 225),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0, left: 9),
                          child: TextField(
                            controller: titleController,
                            // focusNode: textfieldFocusNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "What Would You Like To Do?",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Color.fromARGB(255, 101, 99, 99),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 70,
                        width: 323,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 228, 225, 225),
                          borderRadius: BorderRadius.circular(5),
                          // color: Color.fromARGB(255, 236, 233, 233),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4.0, left: 9),
                          child: TextField(
                            controller: descriptionController,
                            // focusNode: textfieldFocusNode,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Description",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: Color.fromARGB(255, 101, 99, 99),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 95,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 173, 180, 179),
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              child: CategoryDropDown(
                                text: "Category",
                                // checkDrop: checkDrop,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFF6C6C6C),
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            child: DateDropDown(
                              text: "Date",
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: 88,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 200, 197, 197),
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            child: PriorityDropDown(
                              text: "priority",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: 120,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 200, 197, 197),
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            child: ReminderDropDown(
                              text: "Remainder",
                            ),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Container(
                            width: 71,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 200, 197, 197),
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            child: Center(
                              child: Text(
                                "Emoji",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            // print("categorydropdown is ");
                            // print(authClient.dropDowncategoryOpened);
                            // print(authClient.dropDownDateOpened);
                            // print(authClient.dropDownReminderOpened);
                            // print(authClient.dropDownDateOpened);

                            // print(CategoryDropDown.categoryCheck);
                            if (authClient.dropDowncategoryOpened == false &&
                                authClient.dropDownDateOpened == false &&
                                authClient.dropDownPriorityOpened == false &&
                                authClient.dropDownReminderOpened == false) {
                              print("done all false");
                              createTodoTask(
                                titleController,
                                descriptionController,
                                authClient.categoryTextSelected,
                                dataModel.selectedDate,
                                dataModel.today,
                              );
                            }
                          },
                          child: Container(
                            height: 63,
                            width: 63,
                            // color: Colors.red,
                            child: Image.asset(
                              'assets/TodoScreen1/Group 237.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future<String> createTodoTask(
      TextEditingController title,
      TextEditingController description,
      String category,
      String Selecteddate,
      String today) async {
    try {
      final apiUrl = Uri.parse(
          'https://notesapp-i6yf.onrender.com/user/todoTask/createTask');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final headers = {
        'Content-Type': 'application/json',
        'x-auth-token': '$token',
      };

      final userData = {
        'title': title.text.toString(),
        'description': description.text.toString(),
        'category': category.toString(),
        // 'dueDate': Selecteddate,
        // 'dateTime': today,
      };

      final response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(userData),
      );
      print("TodoTaskCreation");
      print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        print("todoTaskCreatedSuccessfully");
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: HomePage(),
              type: PageTransitionType.fade,
              isIos: true,
              duration: Duration(milliseconds: 900),
            ),
            (route) => false);

        return "${response.statusCode} ${response.body}"; // Data posted successfully
      } else {
        print('HTTP Error: ${response.body}');
        var value = jsonDecode(response.body);
        var message = value['message'];

        showDialog(
          context: context,
          builder: (context) => Center(
            child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 15, 1, 84),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message != null)
                    Text(
                      "$message",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 232, 229, 229),
                          fontFamily: "Google Sans"),
                    ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text("Ok"))
              ],
            ),
          ),
        );

        print('HTTP Error: ${response.body}');
        return "${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(context, profilepic, profilepicUrl, name, email),
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
                    // width: 375,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Builder(
                          builder: (BuildContext builderContext) {
                            return InkWell(
                              onTap: () {
                                Scaffold.of(builderContext).openDrawer();
                              },
                              child: Container(
                                height: 19,
                                width: 23,
                                child: Image.asset(
                                  'assets/todo/Group 388.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 43,
                        ),
                        Container(
                          height: 30,
                          width: 200,
                          // color: Colors.blue,

                          /// match from here
                          child: CustomDropdown(
                            text: "hello",
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
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            // color: Color.fromARGB(255, 187, 184, 184),
                            // color: Colors.blue,
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 12),
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
                                    child: Text("Error: ${snapshot.error}"));
                              } else {
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final cover = snapshot.data![index];
                                    // print(" cover is $cover");
                                    // print(cover.category);
                                    // print(AuthClient().categoryTextSelected);
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        left: 4,
                                      ),
                                      child: (cover != null)
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SingleTaskReader(
                                                              id: value['data']
                                                                      [index]
                                                                  ['_id'],
                                                            )));
                                              },
                                              child: Container(
                                                // color: Colors.green,
                                                height: 40,
                                                child: ListTile(
                                                  leading: Container(
                                                    // color: Colors.red,
                                                    height: 15,
                                                    width: 15,
                                                    child: (cover.completed ==
                                                            false)
                                                        ? Image.asset(
                                                            'assets/TodoScreen1/Group 214.png',
                                                          )
                                                        : Image.asset(
                                                            'assets/TodoScreen1/Ellipse 77.png',
                                                          ),
                                                  ),

                                                  // compare the lit comming with the selectedtext in menu
                                                  // (cover.category ==
                                                  //         AuthClient()
                                                  //             .categoryTextSelected)

                                                  title: Text(
                                                    "${cover.title}",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Text("NO Task Found"),
                                            ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 700,
              left: 29,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskHistory(),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    "Task History",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _showBottomSheet();
            });
          },
          backgroundColor: Colors.white,
          elevation: 0,
          child: Image.asset(
            'assets/TodoScreen1/Group 208.png',
          ),
        ),
      ),
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
              // color: Colors.red,
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
