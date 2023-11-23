// import 'package:esyryt_final_app/authentications/signin.dart';
// import 'package:esyryt_final_app/authentications/signup.dart';
// import 'package:esyryt_final_app/startingPage/IntroDiaryPage.dart';
// import 'package:esyryt_final_app/startingPage/introNotePage.dart';
// import 'package:esyryt_final_app/startingPage/introductoryPage.dart';
// import 'package:flutter/material.dart';

// class StartingPages extends StatelessWidget {
//   const StartingPages({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     List pages = [
//       IntroductoryPage(),
//       IntroNoteScreen(),
//       IntroDiaryPage(),
//       SignUpPage(),
//     ];
//     return SafeArea(
//       child: Scaffold(
//         // backgroundColor: Color.fromARGB(255, 41, 40, 40),
//         body: PageView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: pages.length,
//           itemBuilder: (context, index) {
//             return Container(
//               height: double.maxFinite,
//               width: double.maxFinite,
//               child: pages[index],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
