import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NoteReaderScreen extends StatefulWidget {
  var title, description, formattedDate;
  NoteReaderScreen({this.title, this.description, formattedDate});
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var formattedDate = DateFormat('d MMM, yyyy').format(date).toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   foregroundColor: Colors.white,
        //   backgroundColor: const Color.fromARGB(255, 92, 4, 108),
        //   elevation: 0,
        //   toolbarHeight: 80,
        //   title: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         Icon(
        //           Icons.check,
        //           color: Colors.white,
        //         ),
        //         Icon(
        //           Icons.arrow_circle_left_outlined,
        //           color: Colors.white,
        //         ),
        //         Icon(
        //           Icons.arrow_circle_right_outlined,
        //           color: Colors.white,
        //         ),
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     Text(
        //       "Templetes",
        //       style: TextStyle(
        //         overflow: TextOverflow.clip,
        //         fontSize: 18,
        //         color: Colors.white,
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //     Icon(
        //       Icons.arrow_drop_down,
        //       color: Colors.white,
        //     ),
        //     SizedBox(
        //       width: 30,
        //     ),
        //     Icon(
        //       Icons.menu,
        //       color: Colors.white,
        //     ),
        //     SizedBox(
        //       width: 5,
        //     ),
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "$formattedDate",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${widget.title}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${widget.description}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 82,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9D85DC), Color(0xFF3B305A)],
          stops: [0.1, 0.9],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/2notescreen/Group 276.png',
                width: 18,
                height: 12,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/2notescreen/Vector 9.png',
              width: 26,
              fit: BoxFit.cover,
            ),
          ),
          InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/2notescreen/Vector 8.png',
                width: 26,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/2notescreen/Group 277.png',
                width: 79,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) =>
                        Container(
                      height: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Color(0xff3b305a),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 15),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'assets/2notescreen/Group 283.png',
                                      width: 19,
                                      height: 19,
                                    ),
                                  ),
                                  Text(
                                    'Share',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Bookmark.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Save',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Notebook.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Find in Note',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Notification.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Add Reminder',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/2notescreen/Delete.png',
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                                Text(
                                  'Move To Trash',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/2notescreen/Group 275.png',
                  width: 6,
                  height: 22.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
