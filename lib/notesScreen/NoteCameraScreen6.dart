import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

/// camera screen
class NoteScreen6 extends StatefulWidget {
  const NoteScreen6({Key? key}) : super(key: key);

  @override
  _NoteScreen6State createState() => _NoteScreen6State();
}

class _NoteScreen6State extends State<NoteScreen6> {
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final focusNode = FocusScope.of(context);
      focusNode.addListener(() {
        setState(() {
          isKeyboardOpen = focusNode.hasFocus;
        });
      });
    });
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: InkWell(
        onTap: () {
          pickImage();
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 45, right: 6),
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
            // child: Image.asset('assets/1notescreen/camera.png'),
            child: Icon(Icons.camera_alt, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Stack(
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
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(22, 0, 0, 0),
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(36, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/3notescreen/Vector 9.png',
                              width: 26,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(22, 0, 0, 0),
                          child: Container(
                            // color: Colors.red,
                            // borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/3notescreen/Vector 8.png',
                              width: 28,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(200, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) =>
                                    StatefulBuilder(
                                  builder: (BuildContext context,
                                          StateSetter setState) =>
                                      Container(
                                    height: 250,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: Color(0xff3b305a),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 15),
                                            child: Row(
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
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
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
                                width: 3,
                                height: 14.5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
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

                  /// image here
                  Align(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 544,
                      width: 516,
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.fitWidth,
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
                      width: 348,
                      height: 37,
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.2,
                              offset: Offset(1, 0),
                            )
                          ]),
                      child: Row(
                        children: [
                          //bold
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
