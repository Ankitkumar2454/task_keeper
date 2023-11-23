// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'IntroScreen3.dart';

class IntroScreen2 extends StatefulWidget {
  final VoidCallback onNextPressed;
  const IntroScreen2({super.key, required this.onNextPressed});

  @override
  State<IntroScreen2> createState() => _IntroScreen2State();
}

class _IntroScreen2State extends State<IntroScreen2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_backspace_outlined,
              color: Colors.black87,
            )),
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Stack(
            children: [
              // center to 3
              Positioned(
                top: 199.75,
                left: 41,
                child: Container(
                  height: 234.82,
                  width: 171,
                  // color: Colors.red,
                  child: Image.asset(
                    'assets/introNote/Group 446.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 185,
                left: 80,
                child: Container(
                  height: 234.82,
                  width: 171,
                  // color: Colors.red,
                  child: Image.asset(
                    'assets/introNote/Group 448.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 110,
                child: Container(
                  height: 234.82,
                  width: 171,
                  // color: Colors.red,
                  child: Image.asset(
                    'assets/introNote/Group 447.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 3,
                left: 222,
                child: Container(
                  height: 123.96,
                  width: 125,
                  // color: Colors.red,
                  child: Image.asset(
                    'assets/introNote/Group 421.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 515,
                left: 156,
                child: Container(
                  height: 82.41,
                  width: 83,
                  // color: Colors.red,
                  child: Image.asset(
                    'assets/introNote/Group 417.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 121,
                left: 304,
                child: Container(
                  height: 67.91,
                  width: 67,
                  // color: Colors.red,
                  child: Image.asset(
                    'assets/introNote/Group 419.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 560,
                left: 150,
                child: Container(
                  height: 20,
                  width: 41,
                  child: Image.asset(
                    'assets/introNote/Notes.png',
                    color: Color(0xFF6C6C6C),
                  ),
                ),
              ),
              Positioned(
                top: 600,
                left: 140,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.22,
                  ).copyWith(
                      top: MediaQuery.of(context).size.height * 0.0828479),
                  child: SkipContainer(),
                ),
              ),
            ],
          ),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 16), // Add spacing between circles
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue, // You can change the color
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
