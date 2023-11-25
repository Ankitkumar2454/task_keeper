import 'package:esyryt_final_app/services/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DropDownReminderTime extends StatefulWidget {
  final double itemHeight;
  OverlayEntry floatingReminderTimeDropdown;
  bool isDropdownReminderTimeOpened;
  DropDownReminderTime({
    Key? key,
    required this.itemHeight,
    required this.floatingReminderTimeDropdown,
    required this.isDropdownReminderTimeOpened,
  }) : super(key: key);

  @override
  State<DropDownReminderTime> createState() => _DropDownReminderTimeState();
}

class _DropDownReminderTimeState extends State<DropDownReminderTime> {
  TextEditingController timeController = TextEditingController();
  @override
  void initState() {
    timeController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    TimeOfDay _selectedTime = TimeOfDay.now();

    Future<void> _selectTime() async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );

      if (pickedTime != null && pickedTime != _selectedTime) {
        setState(() {
          _selectedTime = pickedTime;
        });
      }
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
                height: 2.8 * widget.itemHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF6C6C6C).withOpacity(0.7),
                  // color: Color.fromARGB(255, 229, 10, 10).withOpacity(0.7),
                  // borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _selectTime(),
                      child: Container(
                        child: Center(
                          child: Text(
                            _selectedTime.format(context),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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
                clipper: ArrowReminderTimeClipper(),
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
      ),
    );
  }
}

class ArrowReminderTimeClipper extends CustomClipper<Path> {
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
