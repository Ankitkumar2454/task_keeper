// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:esyryt_final_app/helper/dropDown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:esyryt_final_app/services/client.dart';

class ReminderDropDown extends StatefulWidget {
  final String text;
  static bool reminderCheck = false;
  ReminderDropDown({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ReminderDropDown> createState() => _ReminderDropDownState();
}

class _ReminderDropDownState extends State<ReminderDropDown> {
  late GlobalKey actionReminderKey;
  late OverlayEntry floatingReminderDropdown;
  bool isDropdownReminderOpened = false;
  late double rheight, rwidth, rxPosition, ryPosition;
  @override
  void initState() {
    setState(() {
      actionReminderKey = LabeledGlobalKey(widget.text);
      isDropdownReminderOpened = false;
    });

    floatingReminderDropdown = _createFloatingReminderDropdown();
    super.initState();
  }

  void findDropdownReminderData() {
    RenderBox? renderBox =
        actionReminderKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      rheight = renderBox.size.height;
      rwidth = renderBox.size.width;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      rxPosition = offset.dx;
      ryPosition = offset.dy;
    } else {}
  }

  OverlayEntry _createFloatingReminderDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: rxPosition,
        width: rwidth * 2.8,
        top: 420,
        height: 10.5 * rheight,
        child: DropDownReminder(
          itemHeight: rheight,
          isDropdownReminderOpened: isDropdownReminderOpened,
          floatingReminderDropdown: floatingReminderDropdown,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthClient authClient = Provider.of<AuthClient>(context, listen: false);
    return GestureDetector(
      key: actionReminderKey,
      onTap: () {
        setState(() {
          if (isDropdownReminderOpened) {
            floatingReminderDropdown.remove();
          } else {
            findDropdownReminderData();
            floatingReminderDropdown = _createFloatingReminderDropdown();
            Overlay.of(context).insert(floatingReminderDropdown);
          }
          isDropdownReminderOpened = !isDropdownReminderOpened;
          authClient.dropDownReminderCheck(isDropdownReminderOpened);
        });
      },
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
                widget.text,
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

class DropDownReminder extends StatefulWidget {
  double itemHeight;
  OverlayEntry floatingReminderDropdown;
  bool isDropdownReminderOpened;
  DropDownReminder({
    Key? key,
    required this.itemHeight,
    required this.floatingReminderDropdown,
    required this.isDropdownReminderOpened,
  }) : super(key: key);

  @override
  State<DropDownReminder> createState() => _DropDownReminderState();
}

class _DropDownReminderState extends State<DropDownReminder> {
  bool reminderdrop = false;
  bool dailydrop = false;
  bool weeklydrop = false;
  bool monthlydrop = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      height: 50,
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          Material(
            elevation: 0,
            // shape: ArrowShape(),

            color: Color.fromARGB(255, 171, 170, 170).withOpacity(0.7),
            // color: Colors.transparent.withOpacity(0),
            child: Container(
              height: 9.299 * widget.itemHeight,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 103, 102, 102).withOpacity(0.7),
                // color: Colors.blue,
                // borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      // color: Colors.purple,
                      // borderRadius: BorderRadius.circular(13),
                      color: Color(0xFF6C6C6C),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hourly",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              reminderdrop = !reminderdrop;
                            });
                          },
                          child: (reminderdrop == false)
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        )
                      ],
                    ),
                  ),
                  if (reminderdrop)
                    Container(
                      color:
                          Color.fromARGB(255, 156, 154, 154).withOpacity(0.7),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "time",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 2),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "date",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      // color: Colors.purple,

                      // borderRadius: BorderRadius.circular(13),
                      color: Color(0xFF6C6C6C),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Daily",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              dailydrop = !dailydrop;
                            });
                          },
                          child: (dailydrop == false)
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      // color: Colors.purple,

                      // borderRadius: BorderRadius.circular(13),
                      color: Color(0xFF6C6C6C),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Weekly",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              weeklydrop = !weeklydrop;
                            });
                          },
                          child: (weeklydrop == false)
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      // color: Colors.purple,

                      // borderRadius: BorderRadius.circular(13),
                      color: Color(0xFF6C6C6C),
                    ),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Monthly",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              monthlydrop = !monthlydrop;
                            });
                          },
                          child: (monthlydrop == false)
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ClipPath(
                clipper: ArrowReminderClipper(),
                child: Container(
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 60, 59, 59),
                  ),
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
  }
}

class ArrowReminderClipper extends CustomClipper<Path> {
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
