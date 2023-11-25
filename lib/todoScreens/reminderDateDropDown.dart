// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:esyryt_final_app/helper/dropDown.dart';
import 'package:esyryt_final_app/services/client.dart';

// class ReminderDateDropDown extends StatefulWidget {
//   final String text;
//   static bool dateCheck = false;

//   const ReminderDateDropDown({super.key, required this.text});
//   @override
//   State<ReminderDateDropDown> createState() => _ReminderDateDropDownState();
// }

// class _ReminderDateDropDownState extends State<ReminderDateDropDown> {
//   late GlobalKey actionReminderDateKey;
//   late double rdheight, rdwidth, rdxPosition, rdyPosition;

//   bool isDropdownReminderDateOpened = false;
//   late OverlayEntry floatingReminderdateDropdown;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       actionReminderDateKey = LabeledGlobalKey(widget.text);
//       dateController.text = "";
//       // isDropDateOpened = false;
//     });

//     floatingReminderdateDropdown = _createFloatingReminderDateDropdown();
//   }

//   void findDropdownReminderData() {
//     RenderBox? renderBox =
//         actionReminderDateKey.currentContext?.findRenderObject() as RenderBox?;
//     // RenderObject? renderBox =actionKey.currentContext?.findRenderObject();
//     if (renderBox != null) {
//       rdheight = renderBox.size.height;
//       rdwidth = renderBox.size.width;
//       Offset offset = renderBox.localToGlobal(Offset.zero);
//       rdxPosition = offset.dx;
//       rdyPosition = offset.dy;
//     } else {
//       // Handle the case where renderBox is not a RenderBox
//     }
//   }

//   OverlayEntry _createFloatingReminderDateDropdown() {
//     return OverlayEntry(builder: (context) {
//       return Positioned(
//         left: 28,
//         width: rdwidth,
//         top: 172,
//         height: 280,
//         child: DropDownReminderDate(
//           itemHeight: rdheight,
//           isDropdownReminderDateOpened: isDropdownReminderDateOpened,
//           floatingReminderdateDropdown: floatingReminderdateDropdown,
//         ),
//       );
//     });
//   }

//   TextEditingController dateController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     AuthClient authClient = Provider.of<AuthClient>(context, listen: false);
//     return GestureDetector(
//       key: actionReminderDateKey,
//       onTap: () {
//         setState(() {
//           if (isDropdownReminderDateOpened) {
//             floatingReminderdateDropdown.remove();
//           } else {
//             findDropdownReminderData();
//             floatingReminderdateDropdown =
//                 _createFloatingReminderDateDropdown();
//             Overlay.of(context).insert(floatingReminderdateDropdown);
//           }
//           isDropdownReminderDateOpened = !isDropdownReminderDateOpened;

//           authClient.dropDownCheck(isDropdownReminderDateOpened);
//           print(AuthClient().dropDateCheck);

//           authClient.dropDownDateCheck(isDropdownReminderDateOpened);
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Color.fromARGB(255, 200, 197, 197),
//           // color: Color.fromARGB(255, 233, 10, 10),
//         ),
//         // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Text(
//                 widget.text,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class DropDownReminderDate extends StatefulWidget {
  final double itemHeight;
  OverlayEntry floatingReminderdateDropdown;
  bool isDropdownReminderDateOpened;
  DropDownReminderDate({
    Key? key,
    required this.itemHeight,
    required this.floatingReminderdateDropdown,
    required this.isDropdownReminderDateOpened,
  }) : super(key: key);

  @override
  State<DropDownReminderDate> createState() => _DropDownReminderDateState();
}

class _DropDownReminderDateState extends State<DropDownReminderDate> {
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    dateController.text = "";
  }

  DateTime today = DateTime.now();
  String? formattedSelectedDate;
  String? formattedtoday;
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    void _ondaySelected(DateTime day, DateTime focusedDay) {
      //date format = 2023-11-25T09:00:00.000Z
      setState(() {
        DateTime selectedDate = day;
        formattedSelectedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
        formattedtoday = DateFormat('yyyy-MM-dd').format(today);
        print('Formatted Date: $formattedSelectedDate');
        AuthClient().updateDate(formattedSelectedDate!, formattedtoday!);
      });
    }

    return Material(
      color: Color(0xFF6C6C6C),
      child: Container(
        // color: Colors.pink,
        height: 30,
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 23,
              // shape: ArrowShape(),
              child: Container(
                height: 13 * widget.itemHeight,
                decoration: BoxDecoration(
                  color: Color(0xFF6C6C6C).withOpacity(0.7),
                  // color: Color.fromARGB(255, 229, 10, 10).withOpacity(0.7),
                  // borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TableCalendar(
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, date, events) {
                            return Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                        locale: "en_Us",
                        focusedDay: today,
                        rowHeight: 30,
                        headerVisible: false,
                        weekNumbersVisible: false,
                        daysOfWeekVisible: false,
                        firstDay: DateTime.utc(2023, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        headerStyle: HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        availableGestures: AvailableGestures.all,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        onDaySelected: _ondaySelected,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Align(
              alignment: Alignment(-0.8, 0),
              child: ClipPath(
                clipper: ArrowReminderDateClipper(),
                child: Container(
                  height: 16,
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
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
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
      ),
    );
  }
}

class ArrowReminderDateClipper extends CustomClipper<Path> {
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
