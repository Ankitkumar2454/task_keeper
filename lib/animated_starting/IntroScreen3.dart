// ignore_for_file: file_names

import 'package:esyryt_final_app/authentications/finalSignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // Wrap with MaterialApp
        home: IntroScreen3(),
        debugShowCheckedModeBanner: false);
  }
}

class IntroScreen3 extends StatefulWidget {
  const IntroScreen3({super.key});

  @override
  State<IntroScreen3> createState() => _IntroScreen3State();
}

class _IntroScreen3State extends State<IntroScreen3>
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
    print("Height: ${MediaQuery.of(context).size.height}");

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
        child: Stack(
          children: [
            Positioned(
              top: 203,
              left: 106.0,
              child: Container(
                height: 272,
                width: 203,
                child: Image.asset(
                  'assets/introDiary/Rectangle 53.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 220,
              left: 285.0,
              child: Container(
                height: 225,
                width: 12,
                // color: Colors.green,
                child: Image.asset(
                  'assets/introDiary/My Diary.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 166,
              left: 65.0,
              child: Container(
                height: 272,
                width: 203,
                child: Image.asset(
                  'assets/introDiary/RectangleWhite.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 192,
              left: 132.0,
              child: Container(
                height: 54,
                width: 64,
                child: Image.asset(
                  'assets/introDiary/Rectangle 97.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 269,
              left: 111.0,
              child: Container(
                height: 86,
                width: 110,
                child: Image.asset(
                  'assets/introDiary/MyDiary.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 227,
              left: 82.83,
              child: Container(
                height: 147,
                width: 9,
                child: Image.asset(
                  'assets/introDiary/Group 348.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 222,
              left: 81.83,
              child: Container(
                height: 157,
                width: 11,
                child: Image.asset(
                  'assets/introDiary/Group 347.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 242.0,
              child: Container(
                height: 225,
                width: 12,
                child: Image.asset(
                  'assets/introDiary/My Diary.png',
                  fit: BoxFit.cover,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 390.94,
              left: 93.57,
              child: Container(
                height: 23.26,
                width: 144.58,
                child: Image.asset(
                  'assets/introDiary/Group 344.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 420,
              left: 134.57,
              child: Container(
                height: 23.26,
                width: 144,
                child: Image.asset(
                  'assets/introDiary/line.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 560,
              left: 175,
              child: Container(
                // color: Colors.blue,
                height: 20,
                width: 45,
                child: Image.asset(
                  'assets/introDiary/Diary.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: 170,
              child: Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.22,
                ).copyWith(top: MediaQuery.of(context).size.height * 0.0828479),
                child: SkipContainer(),
              ),
            ),
            // Positioned(
            //   top: 700,
            //   left: 155,
            //   child: Container(
            //     // color: Colors.blue,
            //     height: 6,
            //     width: 65,
            //     child: Image.asset(
            //       'assets/introDiary/Group 6.png',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 32,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xff6C6C6C),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
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
            color: Colors.grey, // You can change the color
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
      ],
    );
  }
}
