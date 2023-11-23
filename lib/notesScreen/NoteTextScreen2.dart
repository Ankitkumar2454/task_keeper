import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteScreen2 extends StatefulWidget {
  const NoteScreen2({super.key});

  @override
  State<NoteScreen2> createState() => _NoteScreen2State();
}

class _NoteScreen2State extends State<NoteScreen2> {
  TextEditingController titleController = TextEditingController();
  TextEditingController writingController = TextEditingController();

  // Flag to track whether the keyboard is open
  bool isKeyboardOpen = false;
  bool isbold = false;
  bool isitalic = false;
  bool isunderline = false;
  File? selectedImage;
  String? selectedText;
  @override
  void initState() {
    super.initState();

    // Listen for changes in the keyboard state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final focusNode = FocusScope.of(context);
      focusNode.addListener(() {
        setState(() {
          isKeyboardOpen = focusNode.hasFocus;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: InkWell(
        //   onTap: () {},
        //   child: Image.asset('assets/2notescreen/add.png'),
        // ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/2notescreen/Group 276.png',
                              width: 18,
                              height: 19,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                          
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/2notescreen/Vector 9.png',
                              width: 26,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/2notescreen/Vector 8.png',
                            width: 26,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                  builder: (BuildContext context,
                                          StateSetter setState) =>
                                      Container(
                                    height: 260,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: Color(0xff6C6C6C),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 15),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(0xff6C6C6C),
                                                    ),
                                                    color: Color(0xff6C6C6C),
                                                  ),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.white,
                                                    // size: 25,
                                                  )),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Image.asset(
                                                        'assets/2notescreen/Group 283.png',
                                                        width: 19,
                                                        height: 19,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Share',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xffffffff),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 15),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
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
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 15),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
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
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 15),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
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
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 15),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
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
                                                  color:
                                                      const Color(0xff000000),
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
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: TextFormField(
                      controller: titleController,
                      maxLines: 2,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFFBFBFBF),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Container(
                      width: 345,
                      height: 96,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: TextFormField(
                          controller: writingController,
                          textInputAction: TextInputAction.done,
                          maxLines: 5,
                          autofocus: true,
                          obscureText: false,
                          onChanged: (text) {
                            // Update the selected text when the text changes
                            selectedText = text;
                          },
                          style: TextStyle(
                            fontWeight:
                                isbold ? FontWeight.bold : FontWeight.normal,
                            fontStyle:
                                isitalic ? FontStyle.italic : FontStyle.normal,
                            decoration: isunderline
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Start Writing',
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xFFBFBFBF),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Container(
                      height: 346,
                      width: 280,
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  )
                ],
              ),
            ),
            if (isKeyboardOpen)
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 350,
                      height: 39,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.2,
                              offset: Offset(1, 0),
                            ),
                          ],
                          border: Border.all(width: 0.3)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: InkWell(
                              onTap: () {
                                if (selectedText != null) {
                                  setState(() {
                                    isbold = !isbold;
                                  });
                                }
                              },
                              child: Image.asset('assets/2notescreen/B.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: InkWell(
                              onTap: () {
                                if (selectedText != null) {
                                  setState(() {
                                    isitalic = !isitalic;
                                  });
                                }
                              },
                              child: Image.asset('assets/2notescreen/I.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: InkWell(
                              onTap: () {
                                if (selectedText != null) {
                                  setState(() {
                                    isunderline = !isunderline;
                                  });
                                }
                              },
                              child: Image.asset('assets/2notescreen/U.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: InkWell(
                                onTap: () {},
                                child: Image.asset(
                                    'assets/2notescreen/Select.png')),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: InkWell(
                                onTap: () {},
                                child: Image.asset(
                                    'assets/2notescreen/Pen tool.png')),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: InkWell(
                                onTap: () {},
                                child: Image.asset(
                                    'assets/2notescreen/Group 281.png')),
                          ),
                          Spacer(),

                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     height: 40,
                          //     width: 40,
                          //     // color: Colors.black45,
                          //     child: Stack(
                          //       children: [
                          //         Image.asset(
                          //           'assets/speedChild/Group 283.png',
                          //         ),
                          //         Center(
                          //             child: Icon(
                          //           Icons.add,
                          //           color: Colors.white,
                          //         )),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 3.0, bottom: 4),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5), // Box shadow color
                //     spreadRadius: 5,
                //     blurRadius: 7,
                //     offset: Offset(0, 3), // Offset in x and y directions
                //   ),
                // ],
                color: Colors.grey,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
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
      color: Color(0xff6C6C6C),
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
