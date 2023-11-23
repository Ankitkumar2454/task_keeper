// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:esyryt_final_app/services/client.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:esyryt_final_app/helper/dropDown.dart';

class PriorityDropDown extends StatefulWidget {
  final String text;

  static bool priorityCheck = false;

  PriorityDropDown({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  State<PriorityDropDown> createState() => _PriorityDropDownState();
}

class _PriorityDropDownState extends State<PriorityDropDown> {
  late GlobalKey actionKey;
  late double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  late OverlayEntry floatingDropdown;

  @override
  void initState() {
    super.initState();
    actionKey = LabeledGlobalKey(widget.text);
    isDropdownOpened = false;
  }

  void findDropdownData() {
    RenderBox? renderBox =
        actionKey.currentContext?.findRenderObject() as RenderBox?;
    // RenderObject? renderBox =actionKey.currentContext?.findRenderObject();
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
      // print("hello");
      // print(yPosition - (6 * height));
      // print("hii");
      // print(5.99 * height);
      // print(PriorityDropDown.priorityCheck);
      // print("true");
      return Positioned(
        right: 27,
        width: width * 1.3,
        top: 550,
        height: 130,
        child: DropDowncategory(
          itemHeight: height,
        ),
      );
    });
  }

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthClient authClient = Provider.of<AuthClient>(context, listen: false);
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            // print(widget.checkDrop);
            PriorityDropDown.priorityCheck = false;
            floatingDropdown.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
            PriorityDropDown.priorityCheck = true;
          }
          isDropdownOpened = !isDropdownOpened;
          authClient.dropDownPriorityCheck(isDropdownOpened);
          // authClient.BoxOneAtATime(3);
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

class DropDowncategory extends StatefulWidget {
  final double itemHeight;

  DropDowncategory({super.key, required this.itemHeight});

  @override
  State<DropDowncategory> createState() => _DropDowncategoryState();
}

class _DropDowncategoryState extends State<DropDowncategory> {
  // TextEditingController dateController = TextEditingController();
  // @override
  // void initState() {
  //   dateController.text = "";
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.itemHeight * 4.6);
    return Container(
      // color: Colors.pink,
      height: 105,
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          Material(
            elevation: 23,
            shape: ArrowShape(),
            child: Container(
              height: 3.7 * widget.itemHeight,
              decoration: BoxDecoration(
                  // color: Colors.green,
                  // borderRadius: BorderRadius.circular(15),
                  ),
              child: Column(
                children: <Widget>[
                  DropDownItem(
                    text: "Default",
                    iconData: Icons.bookmark,
                    isSelected: false,
                    color: Colors.red,
                  ),
                  DropDownItem(
                    text: "High",
                    iconData: Icons.bookmark,
                    isSelected: false,
                    color: Colors.yellow,
                  ),
                  DropDownItem(
                    text: "Low",
                    iconData: Icons.bookmark,
                    isSelected: false,
                    color: Colors.blue,
                  ),
                  // DropDownItem(
                  //   text: "Priority 4",
                  //   iconData: Icons.bookmark,
                  //   color: Colors.white38,
                  //   isSelected: false,
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Align(
            alignment: Alignment(0.2, 0),
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
        ],
      ),
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;
  final Color? color;

  const DropDownItem(
      {Key? key,
      required this.text,
      this.iconData,
      this.color,
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
    return SingleChildScrollView(
      child: Container(
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
            Icon(
              iconData,
              color: color,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // path.moveTo(0, size.height);
    // path.lineTo(size.width / 2, 0);
    // path.lineTo(size.width, size.height);
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

// class ArrowShape extends ShapeBorder {
//   @override
//   // TODO: implement dimensions
//   EdgeInsetsGeometry get dimensions => throw UnimplementedError();

//   @override
//   Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
//     // TODO: implement getInnerPath
//     throw UnimplementedError();
//   }

//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     // TODO: implement getOuterPath
//     return getClip(rect.size);
//   }

//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
//     // TODO: implement paint
//   }

//   @override
//   ShapeBorder scale(double t) {
//     // TODO: implement scale
//     throw UnimplementedError();
//   }

//   Path getClip(Size size) {
//     Path path = Path();

//     // path.moveTo(0, size.height);
//     // path.lineTo(size.width / 2, 0);
//     // path.lineTo(size.width, size.height);

//     return path;
//   }
// }
