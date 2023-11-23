// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:esyryt_final_app/helper/dropDown.dart';
import 'package:esyryt_final_app/json/createCategory.dart';
import 'package:esyryt_final_app/json/getAllCategory.dart';
import 'package:esyryt_final_app/services/client.dart';
import 'package:esyryt_final_app/todoScreens/todoScreen1.dart';

class CategoryDropDown extends StatefulWidget {
  final String text;
  static String? categoryText;
  static bool categoryCheck = false;

  CategoryDropDown({
    Key? key,
    required this.text,
    // required this.checkDrop,
  }) : super(key: key);
  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  late GlobalKey actionKey;
  late double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  late OverlayEntry floatingDropdown;

  @override
  void initState() {
    super.initState();
    setState(() {
      actionKey = LabeledGlobalKey(widget.text);
      isDropdownOpened = false;
    });
    CategoryDropDown.categoryCheck = false;
    floatingDropdown = _createFloatingDropdown();
  }

  void findDropdownData() {
    RenderBox? renderBox =
        actionKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      height = renderBox.size.height;
      width = renderBox.size.width;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      xPosition = offset.dx;
      yPosition = offset.dy;
    } else {
      // Handle the case where renderBox is not a RenderBox
    }
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width * 2,
        top: 479,
        height: 7 * height,
        child: DropDowncategory(
          itemHeight: height,
          isDropdownOpened: isDropdownOpened,
          floatingDropdown: floatingDropdown,
        ),
      );
    });
  }

  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthClient authClient = Provider.of<AuthClient>(context, listen: false);
    authClient.context = context;
    // authClient.floatingDropdown = _createFloatingDropdown();
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            if (floatingDropdown?.mounted ?? false) {
              floatingDropdown?.remove();
            }
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
            // authClient.floatingDropDownCheck(true);
          }
          isDropdownOpened = !isDropdownOpened; 
          // true

          // authClient.dropDownCategoryCheck(isDropdownOpened);
          // authClient.dropDownCategoryCheck(false);
          // authClient.dropDownDateCheck(false);
        });
      },

      // category container
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 200, 197, 197),
          // color: Color.fromARGB(255, 233, 10, 10),
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.text, // category
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDowncategory extends StatefulWidget {
  double itemHeight;
  OverlayEntry floatingDropdown;
  bool isDropdownOpened;

  DropDowncategory({
    Key? key,
    required this.itemHeight,
    required this.floatingDropdown,
    required this.isDropdownOpened,
  }) : super(key: key);

  @override
  State<DropDowncategory> createState() => _DropDowncategoryState();
}

class _DropDowncategoryState extends State<DropDowncategory> {
  @override
  var dataCategoryReceived;

  List<GetAllTodoCategory> categoriesList = [];
  Future<List<GetAllTodoCategory>> getAllCategoryList() async {
    final Uri uri = Uri.parse(
        "https://notesapp-i6yf.onrender.com/user/todoTaskCategory/getAllTodoCategory");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final Map<String, String> headers = {'x-auth-token': '$token'};
    final response = await http.get(uri, headers: headers);
    // print("all cate");
    // print(" hiiiiiiii ${response.body}");

    dataCategoryReceived = jsonDecode(response.body);
    // var id = value['data'][0]['_id'];
    // print(id);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> data =
          responseData['data']; // Assuming 'data' contains the list
      categoriesList =
          data.map((json) => GetAllTodoCategory.fromJson(json)).toList();

      return categoriesList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed"),
        ),
      );
      // throw Exception('Failed to load data');
      return categoriesList;
    }
  }

  var data;
  var value;
  var messageResponse;

  Future<String> createCategoryList(String textController) async {
    try {
      final apiUrl = Uri.parse(
          'https://notesapp-i6yf.onrender.com/user/todoTaskCategory/createTodoCategory');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final headers = {
        'Content-Type': 'application/json',
        'x-auth-token': '$token',
      };

      final userData = {
        'category': textController,
      };

      final response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return "${response.statusCode} ${response.body}"; // Data posted successfully
      } else {
        print('HTTP Error: ${response.statusCode}');
        return "${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }

  TextEditingController? newCategoryController;
  void _showCreateNewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        newCategoryController = TextEditingController();
        return Stack(
          children: [
            Positioned(
              top: 150,
              child: AlertDialog(
                title: Text("New Category"),
                content: TextField(
                  controller: newCategoryController,
                  decoration: InputDecoration(labelText: "Category Name"),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (mounted) {
                        String newCategoryinput =
                            newCategoryController!.text.trim();
                        if (newCategoryinput.isNotEmpty) {
                          createCategoryList(newCategoryinput);
                        }
                      }

                      Navigator.of(context).pop();
                    },
                    child: Text("Create"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void DeleteSingleTaskDetails(String _id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      // the response we are getting is a response.body
      var response = await AuthClient().DeletesingleCategory(
          '/user/todoTaskCategory/deleteToDoCategory/$_id', token!);
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
  Widget build(BuildContext context) {
    OverlayEntry floatingDropdown = widget.floatingDropdown;
    String selectedCategoryfromButton;
    var isSelected = false;
    AuthClient authClient = Provider.of<AuthClient>(context, listen: false);

    return Consumer<AuthClient>(builder: (context, authClient, child) {
      return Container(
        // color: Colors.pink,
        // color: Color(0xFF6C6C6C).withOpacity(0.7),
        height: widget.itemHeight * 5,
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 23,
              color: Color(0xFF6C6C6C).withOpacity(0.7),
              // shape: ArrowShape(),
              child: SingleChildScrollView(
                child: Container(
                  height: 6 * widget.itemHeight,
                  decoration: BoxDecoration(
                    // color: Colors.transparent,
                    // color: Colors.blue,
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 2,
                        // color: Colors.blue,
                        color: Color(0xFF6C6C6C).withOpacity(0.7),
                        // shape: ArrowShape(),
                        child: InkWell(
                          onTap: () {
                            print("hii tapped");
                            setState(() {
                              // updatedropDownopened();
                              _showCreateNewDialog();
                              // if (widget.isDropdownOpened == true) {
                              //   floatingDropdown.remove();
                              //   authClient.dropDownOpened = false;
                              // }
                            });
                          },
                          child: Container(
                            // height: widget.itemHeight,
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              color: Color(0xFF6C6C6C).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Create New",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        // height: double.maxFinite,
                        // color: Colors.blue,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Material(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  // color: Colors.purple,
                                  color: Color(0xFF6C6C6C).withOpacity(0.7),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      // color: Colors.green,
                                      child: FutureBuilder<
                                          List<GetAllTodoCategory>>(
                                        future: getAllCategoryList(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 2));
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    "Error: ${snapshot.error}"));
                                          } else {
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                final cover =
                                                    snapshot.data![index];

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 3.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedCategoryfromButton =
                                                            cover.category;
                                                        print("printing ");
                                                        print(
                                                            selectedCategoryfromButton);

                                                        // here gone to authclient the value selected
                                                        authClient.updateCategory(
                                                            selectedCategoryfromButton);
                                                        if (widget
                                                                .isDropdownOpened ==
                                                            true) {
                                                          floatingDropdown
                                                              .remove();
                                                          authClient
                                                                  .dropDownOpened =
                                                              false;
                                                        }
                                                      });
                                                    },
                                                    onLongPress: () {
                                                      if (widget
                                                              .isDropdownOpened ==
                                                          true) {
                                                        floatingDropdown
                                                            .remove();
                                                        authClient
                                                                .dropDownOpened =
                                                            false;
                                                      }

                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "Delete Category"),
                                                            content: Text(
                                                                "Are you sure you want to delete ${cover.category}?"),
                                                            actions: [
                                                              TextButton(
                                                                child: Text(
                                                                    "Cancel"),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text(
                                                                    "Delete"),
                                                                onPressed: () {
                                                                  var _id = dataCategoryReceived[
                                                                          'data']
                                                                      [
                                                                      index]['_id'];
                                                                  print(
                                                                      "the id to be deleted category is ${_id}");

                                                                  DeleteSingleTaskDetails(
                                                                      _id);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      "${cover.category}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Align(
              alignment: Alignment(-0.6, 0),
              child: ClipPath(
                clipper: ArrowClipper(),
                child: Container(
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 60, 59, 59),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      );
    });
  }
}

class DropDownItem extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;

  const DropDownItem(
      {Key? key,
      required this.text,
      this.iconData,
      this.isSelected = false,
      this.isFirstItem = false,
      this.isLastItem = false})
      : super(key: key);

  factory DropDownItem.first(
      {required String text,
      required IconData iconData,
      required bool isSelected}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      isSelected: isSelected,
      isFirstItem: true,
    );
  }

  factory DropDownItem.last(
      {required String text,
      required IconData iconData,
      required bool isSelected}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      isSelected: isSelected,
      isLastItem: true,
    );
  }

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
// check here
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: widget.isFirstItem ? Radius.circular(8) : Radius.zero,
            bottom: widget.isLastItem ? Radius.circular(8) : Radius.zero,
          ),
          color: Colors.purple,
          // color: widget.isSelected
          //     ? Colors.red.shade900
          //     : Color(0xFF6C6C6C).withOpacity(0.7),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Container(
          child: Row(
            children: [
              Text(
                widget.text, // work , personal ....
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0); // Start from the top-left corner
    path.lineTo(size.width, 0); // Draw a line to the top-right corner
    path.lineTo(
        size.width / 2, size.height); // Draw a line to the bottom-center
    path.close(); // Close the path to form a triangular shape

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
