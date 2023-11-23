// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'IntroScreen2.dart';

class IntroScreen1 extends StatefulWidget {
  final VoidCallback onNextPressed;
  const IntroScreen1({super.key, required this.onNextPressed});

  @override
  State<IntroScreen1> createState() => _IntroScreen1State();
}

class _IntroScreen1State extends State<IntroScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
// Set the status bar color, including the area behind system icons, to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Color of the status bar
          statusBarIconBrightness: Brightness
              .dark, // Brightness of system icons (e.g., network, battery)
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    // Create an animation controller with a duration
    _controller = AnimationController(
      vsync: this, // Use the widget's TickerProvider
      duration: Duration(milliseconds: 700), // Adjust the duration as needed
    );

    // Create an animation with a curve
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Stack(
          children: [
            Positioned(
              top: -1,
              child: Container(
                // color: Colors.red,
                height: 131,
                width: 129,
                child: Image.asset(
                  'assets/introductory/Group 420.png',
                  // color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            Positioned(
              top: 721,
              left: -26,
              child: Container(
                // color: Colors.red,
                height: 82,
                width: 83,
                child: Image.asset(
                  'assets/introductory/Group 417.png',
                  color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            Positioned(
              top: 73,
              left: 211,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 74,
                    width: 88,
                    child: Image.asset(
                      'assets/introductory/options-lines.png',
                      color: Color(0xFF6C6C6C),
                    ),
                  ),
                  Container(
                    height: 18,
                    width: 64,
                    child: Center(
                      child: Text(
                        "categories",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 172,
              left: 249,
              child: Container(
                height: 4,
                width: 4,
                child: Image.asset(
                  'assets/introductory/Ellipse 107.png',
                  color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            Positioned(
              top: 146,
              left: 97,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 61,
                    width: 73,
                    child: Image.asset(
                      'assets/introductory/calendar.png',
                      color: Color(0xFF6C6C6C),
                    ),
                  ),
                  Container(
                    height: 18,
                    width: 64,
                    child: Center(
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 228,
              left: 142,
              child: Container(
                height: 4,
                width: 4,
                child: Image.asset(
                  'assets/introductory/Ellipse 107.png',
                  color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            Positioned(
              top: 285,
              left: 18,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 80,
                      width: 94,
                      child: Image.asset(
                        'assets/introductory/prioritize.png',
                        color: Color(0xFF6C6C6C),
                      ),
                    ),
                  ),
                  Container(
                    height: 18,
                    width: 64,
                    child: Center(
                      child: Text(
                        "priority",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 317,
              left: 113,
              child: Container(
                height: 4,
                width: 4,
                child: Image.asset(
                  'assets/introductory/Ellipse 107.png',
                  color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            Positioned(
              top: 462,
              left: 47,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 105,
                    width: 124,
                    child: Image.asset(
                      'assets/introductory/bell.png',
                      color: Color(0xFF6C6C6C),
                    ),
                  ),
                  Container(
                    height: 18,
                    width: 58,
                    child: Center(
                      child: Text(
                        "Reminder",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 455,
              left: 138,
              child: Container(
                height: 4,
                width: 4,
                child: Image.asset(
                  'assets/introductory/Ellipse 107.png',
                  color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            Positioned(
              top: 450,
              left: 282,
              child: Container(
                height: 4,
                color: Colors.red,
                width: 4,
                child: Image.asset(
                  'assets/introductory/Ellipse 107.png',
                  color: Color(0xFF6C6C6C),
                ),
              ),
            ),
            Positioned(
              top: 460,
              left: 250,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 53,
                    width: 63,
                    child: Image.asset(
                      'assets/introductory/laugh.png',
                      color: Color(0xFF6C6C6C),
                    ),
                  ),
                  Container(
                    height: 18,
                    width: 64,
                    child: Center(
                      child: Text(
                        "Emoji",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 197,
              left: 168,
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 249,
                    width: 190,
                    child: Image.asset(
                      'assets/introductory/Group 262.png',
                      // color: Color(0xFF6C6C6C),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 670,
              left: 169,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  // color: Colors.black38,
                  height: 20,
                  width: 41,
                  child: Image.asset(
                    'assets/introTodo/ToDo.png',
                    color: Color(0xFF6C6C6C),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 680,
              left: 160,
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.22,
                ).copyWith(top: MediaQuery.of(context).size.height * 0.0828479),
                child: SkipContainer(),
              ),
            ),
            Positioned(
              top: 674,
              left: 284,
              child: Container(
                // color: Colors.red,
                height: 180,
                width: 181,
                child: Image.asset(
                  'assets/introductory/Group 420.png',
                  // color: Color.fromARGB(255, 240, 236, 236),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 32,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xff6C6C6C),
          onPressed: () {
            widget.onNextPressed();
          },
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "MontserratRegular",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkipContainer extends StatelessWidget {
  const SkipContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 16), // Add spacing between circles
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey, // You can change the color
          ),
        ),
        SizedBox(width: 16), // Add spacing between circles
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey, // You can change the color
          ),
        ),
      ],
    );
  }
}
