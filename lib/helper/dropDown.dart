// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:esyryt_final_app/json/getAllCategory.dart';
import 'package:esyryt_final_app/services/client.dart';

class CustomDropdown extends StatefulWidget {
  final String text;

  const CustomDropdown({Key? key, required this.text}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late GlobalKey actionKey;
  late double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  late OverlayEntry floatingDropdown;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
    isDropdownOpened = false;
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
      print(height);
      print(width);
      print(xPosition);
      print(yPosition);
    } else {
      // Handle the case where renderBox is not a RenderBox
    }
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        height: 9 * height,
        child: DropDown(
          itemHeight: height,
          isDropdownOpened: isDropdownOpened,
          floatingDropdown: floatingDropdown,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthClient authClient = Provider.of<AuthClient>(context, listen: false);
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (floatingDropdown?.mounted ?? false) {
            floatingDropdown?.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }

          isDropdownOpened = !isDropdownOpened;
          authClient.dropDownCheck(isDropdownOpened);
        });
      },
      child: Container(
        // width: 700,
        // height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 151, 150, 150),
          // color: Color.fromARGB(255, 233, 10, 10),
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 6.0,
              ),
              child: Container(
                width: 140,
                // color: Colors.green,
                child: Text(
                  "${_DropDownState.selectedText}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 1.0),
              child: Icon(
                (isDropdownOpened)
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  final double itemHeight;
  OverlayEntry floatingDropdown;
  bool isDropdownOpened;
  DropDown({
    Key? key,
    required this.itemHeight,
    required this.floatingDropdown,
    required this.isDropdownOpened,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  static String selectedText = 'hello';

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

  List<GetAllTodoCategory> categoriesList = [];
  var dataCategoryReceived;
  Future<List<GetAllTodoCategory>> getAllCover() async {
    final Uri uri = Uri.parse(
        "https://notesapp-i6yf.onrender.com/user/todoTaskCategory/getAllTodoCategory");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final Map<String, String> headers = {'x-auth-token': '$token'};
    final response = await http.get(uri, headers: headers);

    print("all cate");
    print(" hiii this is menu drop down ${response.body}");

    dataCategoryReceived = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> data =
          responseData['data']; // Assuming 'data' contains the list
      categoriesList =
          data.map((json) => GetAllTodoCategory.fromJson(json)).toList();

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
      return categoriesList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed"),
        ),
      );
      throw Exception('Failed to load data');
    }
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

  TextEditingController? newCategoryController;
  void _showCreateNewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        newCategoryController = TextEditingController();

        return Align(
          alignment: Alignment.bottomCenter,
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
                  setState(() {
                    String newCategoryinput =
                        newCategoryController!.text.trim();

                    if (newCategoryinput.isNotEmpty) {
                      createCategoryList(newCategoryinput);
                    }
                  });

                  Navigator.of(context).pop();
                },
                child: Text("Create"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    OverlayEntry floatingDropdown = widget.floatingDropdown;
    // String selectedCategoryfromButton;
    AuthClient authClient = Provider.of<AuthClient>(context, listen: false);
    return Consumer<AuthClient>(
      builder: (context, authClient, child) {
        return Container(
          // color: Colors.pink,
          height: widget.itemHeight * 8,
          width: double.maxFinite,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 3,
              ),
              Align(
                alignment: Alignment(0.7, 0),
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
              Material(
                elevation: 23,
                // color: Color(0xFF6C6C6C).withOpacity(0.7),
                color: Colors.transparent,
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
                                          future: getAllCover(),
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
                                                itemCount:
                                                    snapshot.data!.length,
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
                                                          selectedText =
                                                              cover.category;
                                                          print(selectedText);
                                                          AuthClient()
                                                              .updateCategory(
                                                                  selectedText);
                                                          // print(
                                                          //     "selected text from menu is ${AuthClient().categoryTextSelected}");
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

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            backgroundColor:
                                                                Colors.green,
                                                            content: Text(
                                                                " Category $selectedText Selected"),
                                                          ),
                                                        );
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
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                      "Delete"),
                                                                  onPressed:
                                                                      () {
                                                                    var _id = dataCategoryReceived['data']
                                                                            [
                                                                            index]
                                                                        ['_id'];
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
                                                        "${cover.category}", // work , personal ....
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
                              SizedBox(
                                height: 8,
                              ),
                              Material(
                                elevation: 2,
                                // color: Colors.transparent,
                                color: Color.fromARGB(255, 156, 154, 154)
                                    .withOpacity(0.7),
                                // shape: ArrowShape(),
                                child: InkWell(
                                  onTap: () {
                                    print("hii tapped");
                                    setState(() {
                                      // updatedropDownopened();
                                      _showCreateNewDialog();
                                    });
                                  },
                                  child: Container(
                                    // height: widget.itemHeight,
                                    decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      // color: Color(0xFF6C6C6C).withOpacity(0.7),
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
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
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
              // Material(
              //   elevation: 23,
              //   // shape: ArrowShape(),
              //   child: Container(
              //     height: 6 * itemHeight,
              //     decoration: BoxDecoration(
              //       // color: Colors.green,
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: Column(
              //       children: <Widget>[
              //         DropDownItem.first(
              //           text: "Default",
              //           iconData: Icons.add_circle_outline,
              //           isSelected: false,
              //         ),
              //         DropDownItem(
              //           text: "Personal",
              //           iconData: Icons.person_outline,
              //           isSelected: false,
              //         ),
              //         DropDownItem(
              //           text: "Shoppig",
              //           iconData: Icons.settings,
              //           isSelected: false,
              //         ),
              //         DropDownItem(
              //           text: "Wishlist",
              //           iconData: Icons.exit_to_app,
              //           isSelected: false,
              //         ),
              //         DropDownItem(
              //           text: "Work",
              //           iconData: Icons.exit_to_app,
              //           isSelected: false,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 3,
              ),
              // Material(
              //   elevation: 23,
              //   shape: ArrowShape(),
              //   child: Container(
              //     height: itemHeight,
              //     decoration: BoxDecoration(
              //       color: Color(0xFF6C6C6C).withOpacity(0.7),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Row(
              //       children: <Widget>[
              //         Icon(
              //           Icons.add,
              //           color: Colors.white,
              //         ),
              //         Text(
              //           "New List",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 15,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}

class DropDownItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      // width: 150,

      decoration: BoxDecoration(
        // color: Colors.purple,
        borderRadius: BorderRadius.vertical(
          top: isFirstItem ? Radius.circular(8) : Radius.zero,
          bottom: isLastItem ? Radius.circular(8) : Radius.zero,
        ),
        color: isSelected
            ? Colors.red.shade900
            : Color(0xFF6C6C6C).withOpacity(0.7),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Spacer(),
          // Icon(
          //   iconData,
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowShape extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();

    // path.moveTo(0, size.height);
    // path.lineTo(size.width / 2, 0);
    // path.lineTo(size.width, size.height);

    return path;
  }
}
