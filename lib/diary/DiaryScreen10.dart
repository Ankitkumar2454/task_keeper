import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DairyScreen10 extends StatefulWidget {
  const DairyScreen10({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DairyScreen10State createState() => _DairyScreen10State();
}

class DiaryAppState {
  final String title;
  final String content;

  DiaryAppState(this.title, this.content);
}

class _DairyScreen10State extends State<DairyScreen10> {
  Color selectedColor = Colors.white; // Initially selected color
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  File? image;
  bool _showEmoji = false;
  double _fontSize = 20.0;
  Color _textColor = Colors.black;
  String _fontFamily = 'Roboto';
  bool isItalic = false;
  bool isBold = false;
  bool isUnderlined = false;
  bool isTextStart = true;
  bool isTextEnd = false;
  bool isTextCenter = false;
  // List<String> titleHistory = [];
  // List<String> contentHistory = [];
  // int historyIndex = -1; // The current position in the history
  List<DiaryAppState> appStateHistory = [];
  int historyPointer = -1; // Pointer to the current state

  // Function to handle the date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> saveContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('title', titleController.text);
    prefs.setString('content', contentController.text);
    prefs.setString('selectedDate', selectedDate.toIso8601String());
    prefs.setInt('selectedColor', selectedColor.value);
    // You can save other properties as well, such as selectedDate, selectedColor, etc.
  }

  @override
  void initState() {
    super.initState();
    loadContent();
  }

// void updateContent(String newContent) {
//   if (contentController.text != contentHistory[historyIndex]) {
//     contentHistory.add(contentController.text);
//     historyIndex++;
//   }
//   contentController.text = newContent;
// }
  void updateAppState(String newTitle, String newContent) {
    final currentState =
        DiaryAppState(titleController.text, contentController.text);
    if (historyPointer < appStateHistory.length - 1) {
      // If the pointer is not at the end, remove states that come after the current pointer.
      appStateHistory.removeRange(historyPointer + 1, appStateHistory.length);
    }
    appStateHistory.add(currentState);
    historyPointer++;
    titleController.text = newTitle;
    contentController.text = newContent;
  }

// void updateTitle(String newTitle) {
//   if (titleController.text != titleHistory[historyIndex]) {
//     titleHistory.add(titleController.text);
//     historyIndex++;
//   }
//   titleController.text = newTitle;
// }

  Future<void> loadContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      titleController.text = prefs.getString('title') ?? '';
      contentController.text = prefs.getString('content') ?? '';
      final selectedDateStr = prefs.getString('selectedDate');
      selectedDate = selectedDateStr != null
          ? DateTime.parse(selectedDateStr)
          : DateTime.now();
      final selectedColorValue = prefs.getInt('selectedColor');
      selectedColor = Color(selectedColorValue ?? Colors.white.value);
      // Load other properties here as well.
    });
  }

  void undo() {
    if (historyPointer > 0) {
      historyPointer--;
      final prevState = appStateHistory[historyPointer];
      titleController.text = prevState.title;
      contentController.text = prevState.content;
    }
  }

  void redo() {
    if (historyPointer < appStateHistory.length - 1) {
      historyPointer++;
      final nextState = appStateHistory[historyPointer];
      titleController.text = nextState.title;
      contentController.text = nextState.content;
    }
  }

// void undo() {
//   if (historyIndex > 0) {
//     historyIndex--;
//     contentController.text = contentHistory[historyIndex];
//     titleController.text = titleHistory[historyIndex];
//   }
// }

// void redo() {
//   if (historyIndex < contentHistory.length - 1) {
//     historyIndex++;
//     contentController.text = contentHistory[historyIndex];
//     titleController.text = titleHistory[historyIndex];
//   }
// }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick Image: $e');
    }
  }

  void toggleItalic() {
    setState(() {
      isItalic = !isItalic;
    });
  }

  void toggleBold() {
    setState(() {
      isBold = !isBold;
    });
  }

  void toggleUnderlined() {
    setState(() {
      isUnderlined = !isUnderlined;
    });
  }

  void toggleTextStart() {
    if (!isTextStart) {
      isTextStart = true;
      isTextCenter = false;
      isTextEnd = false;
    }
    setState(() {});
  }

  void toggleTextEnd() {
    if (!isTextEnd) {
      isTextStart = false;
      isTextCenter = false;
      isTextEnd = true;
    } else {
      isTextStart = true;
      isTextCenter = false;
      isTextEnd = false;
    }
    setState(() {});
  }

  void toggleTextCenter() {
    if (!isTextCenter) {
      isTextStart = false;
      isTextCenter = true;
      isTextEnd = false;
    } else {
      isTextStart = true;
      isTextCenter = false;
      isTextEnd = false;
    }
    setState(() {});
  }

  void showEmoji() {
    setState(() {
      _showEmoji = !_showEmoji;
    });
  }

  void onColorSelected(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void onSizeChange(value) {
    setState(() {
      _fontSize = value;
    });
  }

  void onColorChange(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  void onFamilyChange(String type) {
    setState(() {
      _fontFamily = type.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedSelectedDate = DateFormat('d MMM y').format(selectedDate);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          top: true,
          child: Column(children: [
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
                        width: 25,
                        height: 16,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: undo,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/2notescreen/Vector 9.png',
                        width: 27,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: redo,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/2notescreen/Vector 8.png',
                        width: 27,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        print('IconButton templete Pressed');
                      },
                      child: Image.asset(
                        'assets/2notescreen/Group 277.png',
                        width: 86,
                        height: 22,
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
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    Container(
                              height: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Color(0xff6C6C6C),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
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
                                              color: const Color(0xffffffff),
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
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
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    width: 700,
                    height: MediaQuery.sizeOf(context).height * 0.77,
                    color: selectedColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                formattedSelectedDate,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                              IconButton(
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: const Color(0xFF9D85DC),
                                  size: 28,
                                ), // The icon to display
                                onPressed: () {
                                  _selectDate(context);
                                },
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 50,
                            child: TextField(
                              controller: titleController,
                              maxLines: 2,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Title',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(
                                  color: Color(0xFFBFBFBF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 345,
                            height: 96,
                            child: TextField(
                              controller: contentController,
                              textAlign: isTextStart
                                  ? TextAlign.start
                                  : isTextCenter
                                      ? TextAlign.center
                                      : TextAlign.end,
                              decoration: InputDecoration(
                                hintText: 'Start Writing..',
                                border: InputBorder.none,
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
                              maxLines: null,
                              style: TextStyle(
                                fontSize: _fontSize,
                                color: _textColor,
                                fontFamily: _fontFamily,
                                fontStyle: isItalic
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                                fontWeight: isBold
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                decoration: isUnderlined
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                          image != null
                              ? Image.file(
                                  image!,
                                  width: MediaQuery.sizeOf(context).width * 0.6,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.6,
                                  fit: BoxFit.cover,
                                )
                              : const Text(""),
                        ],
                      ),
                    )),
              ),
            ),
          ])),
      bottomNavigationBar: CustomBottomNavigationBar(
        context: context,
        selectedColor: selectedColor,
        onColorSelected: onColorSelected,
        pickImageCallback: pickImage,
        showEmojiCallback: showEmoji,
        contentController: contentController,
        titleController: titleController,
        fontSize: _fontSize,
        onSizeChange: onSizeChange,
        textColor: _textColor,
        onColorChange: onColorChange,
        fontFamily: _fontFamily,
        onFamilyChange: onFamilyChange,
        isItalic: isItalic,
        isBold: isBold,
        isUnderlined: isUnderlined,
        toggleUnderlinedCallback: toggleUnderlined,
        toggleBoldCallback: toggleBold,
        toggleItalicCallback: toggleItalic,
        isTextStart: isTextStart,
        isTextEnd: isTextEnd,
        isTextCenter: isTextCenter,
        toggleTextStartCallback: toggleTextStart,
        toggleTextEndCallback: toggleTextEnd,
        toggleTextCenterCallback: toggleTextCenter,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatefulWidget {
  final BuildContext context;
  Color selectedColor = Colors.white;
  final Function(Color) onColorSelected;
  final VoidCallback pickImageCallback;
  final VoidCallback showEmojiCallback;
  final TextEditingController contentController;
  final TextEditingController titleController;
  final double fontSize;
  final Function(double) onSizeChange;
  Color textColor = Colors.black;
  final Function(Color) onColorChange;
  final String fontFamily;
  final Function(String) onFamilyChange;

  final VoidCallback toggleBoldCallback;
  final VoidCallback toggleItalicCallback;
  final VoidCallback toggleUnderlinedCallback;

  final bool isUnderlined;
  final bool isBold;
  final bool isItalic;

  final bool isTextStart;
  final bool isTextCenter;
  final bool isTextEnd;

  final VoidCallback toggleTextStartCallback;
  final VoidCallback toggleTextEndCallback;
  final VoidCallback toggleTextCenterCallback;

  CustomBottomNavigationBar({
    Key? key,
    required this.context,
    required this.selectedColor,
    required this.onColorSelected,
    required this.pickImageCallback,
    required this.showEmojiCallback,
    required this.contentController,
    required this.titleController,
    required this.fontSize,
    required this.onSizeChange,
    required this.textColor,
    required this.onColorChange,
    required this.fontFamily,
    required this.onFamilyChange,
    required this.isUnderlined,
    required this.isBold,
    required this.isItalic,
    required this.toggleBoldCallback,
    required this.toggleItalicCallback,
    required this.toggleUnderlinedCallback,
    required this.isTextStart,
    required this.isTextCenter,
    required this.isTextEnd,
    required this.toggleTextStartCallback,
    required this.toggleTextEndCallback,
    required this.toggleTextCenterCallback,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  List<Color> colorOptions = [
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.brown,
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.brown,
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
    Colors.brown,
  ];

  Color _fontColor = Colors.black;
  void updateFontSize(double newSize) {
    setState(() {
      fontSize = newSize;
    });
  }

  void updateColor(Color newColor) {
    setState(() {
      _fontColor = newColor;
    });
  }

  String _fontFamily = 'Roboto';
  var _newFontWeight = FontWeight.w300;
  final List<Color> colors = [
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.teal,
    Colors.cyan,
    Colors.purple,
  ];
  final _FontWeight = [
    FontWeight.w200,
    FontWeight.w900,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w100,
    FontWeight.w200,
  ];
  double colorSize = 50; // Custom size for color containers
  double paddingBetweenColors = 30;
  double fontSize = 20; // Custom padding between colors
  Color textColor = Colors.black;
  String fontFamily = "Roboto";
  bool isItalic = false;
  bool isBold = false;
  bool isUnderlined = false;
  bool extraBottomItems = false;
  void _showFontTodoBottomSheet() {
    print("entered");
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: _fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Fonts",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: _fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DairyScreen10()),
                          );
                        });
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontFamily: _fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Text(
                        "Size",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: _fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: fontSize,
                          onChanged: (newSize) {
                            updateFontSize(newSize);
                            setState(() {
                              fontSize = newSize;
                            });
                          },
                          min: 15,
                          max: 30,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        color: const Color.fromARGB(255, 209, 211, 214),
                        child: Center(child: Text("${fontSize.round()}")),
                      )
                    ],
                  ),
                ),
                // Container(
                //   color: Colors.white38,
                //   height: 50,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: colors.length,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 8),
                //         child: InkWell(
                //           onTap: () {
                //             setState(() {
                //               _fontColor = colors[index];
                //             });
                //             updateColor(_fontColor);
                //           },
                //           child: Container(
                //             width: 30,
                //             height: 30,
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: colors[index],
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StatefulBuilder(builder: (context, state) {
                    return FastColorPicker(
                      selectedColor: widget.textColor,
                      onColorSelected: (Color color) {
                        state(() {});
                        widget.onColorChange(color);
                      },
                    );
                  }),
                ),
                Container(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    // padding: EdgeInsets.symmetric(horizontal: 17),
                    children: [
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 173, 180, 179),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(child: Text("Regular")),
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 173, 180, 179),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(child: Text("Medium")),
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 173, 180, 179),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                            child: Text(
                          "Bold",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.toggleTextStartCallback();
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 255, 255, 255),
                          ),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.black),
                        ),
                        child: const Icon(Icons.align_horizontal_left),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.toggleTextCenterCallback();
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 255, 255, 255),
                          ),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.black),
                        ),
                        child: const Icon(Icons.align_horizontal_center),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.toggleTextEndCallback();
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 255, 255, 255),
                          ),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.black),
                        ),
                        child: const Icon(Icons.align_horizontal_right),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.deepOrange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.0,
                    ),
                    itemCount: _FontWeight.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _newFontWeight = _FontWeight[index];
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(137, 220, 218, 218),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              (index == 0) ? "Default" : "Bold",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: _fontFamily,
                                fontWeight: (index == 0)
                                    ? FontWeight.w200
                                    : _FontWeight[index],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: const Color.fromARGB(
        //         255, 132, 131, 131), // Set the shadow color
        //     blurRadius: 0.4, // Set the blur radius
        //     offset: Offset(0, -3), // Set the vertical offset
        //   ),
        // ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: [
          if (extraBottomItems == false)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset(
                  'assets/diary/Group 290.png',
                  height: 20,
                  width: 20,
                ),
                color: Colors.black,
                // iconSize: 20,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => buildSheet(),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                ),
              ),
              label: 'Background',
            ),
          if (extraBottomItems == false)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset(
                  'assets/diary/Add.png',
                  height: 20,
                  width: 20,
                ),
                color: Colors.black,
                iconSize: 20,
                onPressed: () => widget.pickImageCallback(),
              ),
              label: 'Images',
            ),
          if (extraBottomItems == false)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset(
                  'assets/diary/Magic wand.png',
                  height: 20,
                  width: 20,
                ),
                color: Colors.black,
                iconSize: 20,
                onPressed: () {
                  print("hello");
                  _showFontTodoBottomSheet();
                  setState(() {});
                },
              ),
              label: 'Effects',
            ),
          if (extraBottomItems == false)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset(
                  'assets/diary/Smiley.png',
                  height: 20,
                  width: 20,
                ),
                // color: const Color.fromARGB(255, 164, 162, 162),
                iconSize: 20,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  //useSafeArea: true,
                  builder: (context) => buildSheet2(),
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  isScrollControlled: true,
                ),
              ),
              label: 'Emoji',
            ),
          if (extraBottomItems == false)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(
                  Icons.text_fields_outlined,
                  size: 20,
                ),
                color: Colors.black,
                iconSize: 20,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => buildSheet3(),
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  isScrollControlled: true,
                ),
              ),
              label: 'Text',
            ),
// from here extra item starts
          if (extraBottomItems == true)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset(
                  'assets/diary/Tag.png',
                  height: 20,
                  width: 20,
                ),
                // color: const Color.fromARGB(255, 164, 162, 162),
                iconSize: 20,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  //useSafeArea: true,
                  builder: (context) => buildSheet2(),
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  isScrollControlled: true,
                ),
              ),
              label: 'Tag',
            ),
          if (extraBottomItems == true)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset(
                  'assets/diary/Voice search.png',
                  height: 20,
                  width: 20,
                ),
                // color: const Color.fromARGB(255, 164, 162, 162),
                iconSize: 20,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  //useSafeArea: true,
                  builder: (context) => buildSheet2(),
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  isScrollControlled: true,
                ),
              ),
              label: 'Voice search',
            ),
          if (extraBottomItems == true)
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset(
                  'assets/diary/Pencil.png',
                  height: 20,
                  width: 20,
                ),
                // color: const Color.fromARGB(255, 164, 162, 162),
                iconSize: 20,
                onPressed: () => showModalBottomSheet(
                  context: context,
                  //useSafeArea: true,
                  builder: (context) => buildSheet2(),
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  isScrollControlled: true,
                ),
              ),
              label: 'write',
            ),
          // for extra items
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Image.asset(
                'assets/diary/Group 353.png',
                height: 20,
                width: 20,
              ),
              color: Colors.black,
              iconSize: 20,
              onPressed: () {
                setState(() {
                  extraBottomItems = !extraBottomItems;
                });
              },
            ),
            label: ' ',
          ),
        ],
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w500, fontSize: 8),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        elevation: 0,
      ),
    );
  }

  Widget makeDismissible(
          {required BuildContext context, required Widget child}) =>
      GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ));

  Widget buildSheet() {
    // 70% of screen height
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black, // Set the shadow color
                  blurRadius: 10.0, // Set the blur radius
                  offset: Offset(0, -3), // Set the vertical offset
                ),
              ],
              color: Color.fromARGB(255, 204, 202, 202),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Theme',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              )),
              Expanded(
                child: GridView.builder(
                  controller: controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio:
                        colorSize / (colorSize + paddingBetweenColors),
                    crossAxisSpacing: paddingBetweenColors,
                    mainAxisSpacing: paddingBetweenColors,
                  ),
                  itemCount: colorOptions.length,
                  itemBuilder: (context, index) {
                    final color = colorOptions[index];
                    return InkWell(
                      onTap: () {
                        widget.onColorSelected(color);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: colorSize,
                        height: colorSize,
                        color: color,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet2() {
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black, // Set the shadow color
                  blurRadius: 10.0, // Set the blur radius
                  offset: Offset(0, -3), // Set the vertical offset
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: EmojiPicker(
                  textEditingController: widget
                      .contentController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                  config: Config(
                    columns: 6,
                    emojiSizeMax: 32 *
                        (Platform.isAndroid
                            ? 1.30
                            : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet3() {
    // 70% of screen height
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.7,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black, // Set the shadow color
                  blurRadius: 10.0, // Set the blur radius
                  offset: Offset(0, -3), // Set the vertical offset
                ),
              ],
              color: Color.fromARGB(255, 250, 250, 250),
              // color: Color.fromARGB(255, 177, 15, 15),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Fonts',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Size :', style: TextStyle(fontSize: 16)),
                  StatefulBuilder(builder: (context, state) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Slider(
                        value: fontSize,
                        activeColor: const Color(0xFF3B305A),
                        inactiveColor: Colors.grey,
                        onChanged: (double value) {
                          state(() {});
                          setState(() {
                            fontSize = value;
                            widget.onSizeChange(fontSize);
                          });
                        },
                        min: 18,
                        max: 70,
                      ),
                    );
                  }),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StatefulBuilder(builder: (context, state) {
                  return FastColorPicker(
                    selectedColor: widget.textColor,
                    onColorSelected: (Color color) {
                      state(() {});
                      widget.onColorChange(color);
                    },
                  );
                }),
              ),
              // all alignments text type
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.toggleItalicCallback();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 255, 255),
                        ),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: const Text('I',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.toggleBoldCallback();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 255, 255),
                        ),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: const Text('B',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.toggleUnderlinedCallback();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 255, 255),
                        ),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: const Text('U',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.toggleTextStartCallback();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 255, 255),
                        ),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: const Icon(Icons.align_horizontal_left),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.toggleTextCenterCallback();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 255, 255),
                        ),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: const Icon(Icons.align_horizontal_center),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.toggleTextEndCallback();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 255, 255),
                        ),
                        foregroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                      ),
                      child: const Icon(Icons.align_horizontal_right),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
