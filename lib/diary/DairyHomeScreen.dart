import 'package:esyryt_final_app/diary/DiaryScreen10.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DairyHomeScreen extends StatefulWidget {
  const DairyHomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DairyHomeScreenState createState() => _DairyHomeScreenState();
}

class _DairyHomeScreenState extends State<DairyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 82,
                  color: Color(0xff6C6C6C),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                        child: Container(
                          width: 23,
                          height: 12,
                          child: Image.asset(
                            'assets/NoteScreen1/Group 211.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Diary',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/1notescreen/Group 263.png',
                            width: 21,
                            height: 21,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.9,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0.0,
                        top: -33.0,
                        child: Image.asset(
                          'assets/diary/Vector 1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0.4,
                        top: 300.0,
                        child: Image.asset(
                          'assets/diary/Vector 2.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        left: 0.0,
                        top: 443.0,
                        child: Image.asset(
                          'assets/diary/Vector 4.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // main diary
                      Positioned(
                        left: 98.0,
                        top: 180.0,
                        child: Container(
                          height: 245,
                          width: 185,
                          child: Image.asset(
                            'assets/diary/Group 349.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 135.0,
                        top: 450.0,
                        child: Container(
                          height: 58,
                          // width: 109,
                          child: Image.asset(
                            'assets/diary/Diary.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 43.0,
                        top: 515.0,
                        child: Container(
                          // color: Colors.red,
                          height: 50,
                          width: 280,
                          child: Image.asset(
                            'assets/diary/Tap.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DairyScreen10()));
        },
        backgroundColor: Colors.white,
        elevation: 0,
        child: Image.asset(
          'assets/TodoScreen1/Group 208.png',
          fit: BoxFit.contain,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

// class CustomBottomNavigationBar extends StatelessWidget {
//   const CustomBottomNavigationBar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.grey, // Set the shadow color
//           //     blurRadius: 10.0, // Set the blur radius
//           //     offset: Offset(0, -3), // Set the vertical offset
//           //   ),
//           // ],
//           ),
//       child: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: IconButton(
//               icon: const Icon(Icons.note_alt),
//               disabledColor: Colors.black,
//               color: Colors.black,
//               iconSize: 30,
//               onPressed: () {
//                 // Add your home button action here
//                 // For example, navigate to the home page
//               },
//             ),
//             label: 'To Do',
//           ),
//           BottomNavigationBarItem(
//             icon: IconButton(
//               icon: const Icon(Icons.library_books),
//               color: Colors.black,
//               iconSize: 30,
//               onPressed: () {
//                 // Add your template button action here
//                 // For example, navigate to the template page
//                 // Navigator.push(context,
//                 //         MaterialPageRoute(builder: (context) => const Login()));
//               },
//             ),
//             label: 'Notes',
//           ),
//           BottomNavigationBarItem(
//             icon: IconButton(
//               icon: const Icon(Icons.book),
//               iconSize: 30,
//               onPressed: () {
//                 // Add your cover button action here
//                 // For example, navigate to the cover page
//                 //  Navigator.push(context,
//                 //           MaterialPageRoute(builder: (context) => const Register()));
//               },
//             ),
//             label: 'Diary',
//           ),
//         ],
//         // Customize the font size of the label text
//         selectedFontSize: 18,
//         currentIndex: 2,
//         unselectedFontSize: 18,
//         selectedItemColor: const Color(0xff9D85DC),
//       ),
//     );
//   }
// }
