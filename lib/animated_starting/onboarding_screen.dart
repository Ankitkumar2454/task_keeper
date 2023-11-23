import 'package:esyryt_final_app/animated_starting/IntroScreen1.dart';
import 'package:esyryt_final_app/animated_starting/IntroScreen2.dart';
import 'package:esyryt_final_app/animated_starting/IntroScreen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);


  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    pages = [
      IntroScreen1(
        onNextPressed: () {
          if (_pageController.page!.round() < pages.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 700),
              curve: Curves.ease,
            );
          }
        },
      ),
      IntroScreen2(
        onNextPressed: () {
          if (_pageController.page!.round() < pages.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 700),
              curve: Curves.ease,
            );
          }
        },
      ),
      IntroScreen3(),
    ];
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Swiped to the right, go to the previous page.
          if (_pageController.page!.round() > 0) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 700),
              curve: Curves.ease,
            );
          }
        } else if (details.primaryVelocity! < 0) {
          // Swiped to the left, go to the next page.
          if (_pageController.page!.round() < pages.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 700),
              curve: Curves.ease,
            );
          }
        }
      },
      child: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (int pageIndex) {
          // Do something when the page changes (optional).
        },
      ),
    );
  }
}
