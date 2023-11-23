import 'package:esyryt_final_app/notesScreen/NoteAttachmentScreen3.dart';
import 'package:esyryt_final_app/notesScreen/NoteScreen4.dart';
import 'package:esyryt_final_app/notesScreen/NoteAudioScreen5.dart';
import 'package:esyryt_final_app/notesScreen/NoteCameraScreen6.dart';
import 'package:esyryt_final_app/notesScreen/NoteTextScreen2.dart';
import 'package:esyryt_final_app/notesScreen/signaturePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteScreen1 extends StatefulWidget {
  const NoteScreen1({Key? key}) : super(key: key);

  @override
  _NoteScreen1State createState() => _NoteScreen1State();
}

class _NoteScreen1State extends State<NoteScreen1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: SpeedDial(
          // closeManually: true,
          // buttonSize: Size(100.0, 100.0),
          // animatedIconTheme: IconThemeData(size: 209.0),
          backgroundColor: Colors.white,
          elevation: 0,
          child: Image.asset(
            'assets/TodoScreen1/Group 208.png',
          ),
          // spacing: 190,
          children: [
            SpeedDialChild(
              child: Container(
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black.withOpacity(0.3),
                //       spreadRadius: 1,
                //       blurRadius: 2,
                //       offset: Offset(2, 2),
                //     ),
                //   ],
                // ),
                child: Image.asset(
                  'assets/speedChild/Group 208.png',
                ),
              ),
              label: 'Text Note',
              // backgroundColor: Color(0xff6C6C6C),
              elevation: 0,
              // labelShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.3),
              //     spreadRadius: 8,
              //     blurRadius: 8,
              //     offset: Offset(0, 3),
              //   ),
              // ],
              // shape: KiteShape(),
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              onTap: () {
                // Handle the "Add" button click here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NoteScreen2()));
              },
            ),
            SpeedDialChild(
              child: Image.asset("assets/1notescreen/attachment.png"),
              // backgroundColor: Color(0xff9D85DC),
              label: 'Attachment',
              elevation: 0,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              onTap: () {
                // Handle the "Edit" button click here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NoteScreen3()));
              },
            ),
            SpeedDialChild(
              child: Image.asset(
                'assets/speedChild/Group 266-1.png',
              ),
              // backgroundColor: Color(0xff9D85DC),
              label: 'Handwriting',
              elevation: 0,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              onTap: () {
                // Handle the "Edit" button click here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignaturePage()));
              },
            ),
            SpeedDialChild(
              child: Image.asset(
                'assets/speedChild/Group 267.png',
              ),
              // backgroundColor: Color(0xff9D85DC),
              label: 'Audio',
              elevation: 0,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              onTap: () {
                // Handle the "Edit" button click here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NoteScreen5()));
              },
            ),
            SpeedDialChild(
              child: Image.asset('assets/speedChild/Group 268.png'),
              // backgroundColor: Color(0xff9D85DC),
              label: 'Camera',
              elevation: 0,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              onTap: () {
                // Handle the "Edit" button click here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NoteScreen6()));
              },
            ),
            // You can add more SpeedDialChild widgets for additional options
          ],
        ),
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
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
                        'All Notes',
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
              ],
            ),

            Positioned(
              top: 220,
              left: 52,
              child: Container(
                width: 241,
                height: 254,
                child: Image.asset(
                  'assets/NoteScreen1/Group 262.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Positioned(
            //   top: 450,
            //   left: 100,
            //   child: RichText(
            //     textScaleFactor: MediaQuery.of(context).textScaleFactor,
            //     text: TextSpan(
            //       children: [
            //         TextSpan(
            //           text: 'CREATE YOUR FIRST',
            //           style: GoogleFonts.staatliches(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.normal,
            //           ),
            //         ),
            //         TextSpan(
            //           text: ' Note',
            //           style: GoogleFonts.merienda(
            //             color: Color(0xFF6751A0),
            //             fontSize: 28,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Positioned(
              top: 499,
              left: 87,
              child: Container(
                width: 210,
                height: 40,
                child: Image.asset(
                  'assets/NoteScreen1/firstNote.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
              top: 553,
              left: 44,
              child: Container(
                width: 290,
                height: 34,
                child: Image.asset(
                  'assets/NoteScreen1/Tap.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 200,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(8),
            //     child: Image.asset(
            //       'assets/1notescreen/Group 261.png',
            //       width: 360,
            //       height: 50,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Positioned(
              top: 700,
              left: 29,
              child: InkWell(
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => TaskHistory(),
                //     ),
                //   );
                // },
                child: Container(
                  width: 100,
                  height: 20,
                  child: Text(
                    "Task History",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KiteShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double x = rect.center.dx;
    double y = rect.center.dy;
    double width = rect.width;
    double height = rect.height;

    Path path = Path();
    path.moveTo(x, y - height / 2); // Top point
    path.lineTo(x - width / 2, y); // Left bottom point
    path.lineTo(x, y + height / 2); // Bottom point
    path.lineTo(x + width / 2, y); // Right bottom point
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // No need to paint anything extra here
  }

  @override
  ShapeBorder scale(double t) {
    return KiteShape(); // You can return a scaled version if needed
  }
}
