import 'dart:convert';
import 'package:esyryt_final_app/todo/dashBoard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class NoteEditorScreen extends StatefulWidget {
  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  double fontSize = 18.0;
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

  Future<void> createPost() async {
    final url =
        Uri.parse('https://notesapp-i6yf.onrender.com/user/createNotes');
    final Map<String, dynamic> data = {
      "title": _titleController.text.trim(),
      "description": _mainController.text.trim(),
      "attachment": [],
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    setState(() {
      if (response.statusCode == 200) {
        print("POST Request Successful");
        print(response.body);
      } else {
        print("Failed, Status code: ${response.statusCode}");
        print(response.body);
      }
    });
  }

  void _showFontTodoBottomSheet() {
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
                                builder: (context) => NoteEditorScreen()),
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
                Container(
                  color: Colors.white38,
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _fontColor = colors[index];
                            });
                            updateColor(_fontColor);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Container(
                      width: 20,
                      height: 30,
                      child: Center(child: Icon(Icons.menu)),
                    ),
                    Container(
                      width: 20,
                      height: 30,
                      child: Center(child: Icon(Icons.menu)),
                    ),
                    Container(
                      width: 20,
                      height: 30,
                      child: Center(child: Icon(Icons.menu)),
                    ),
                  ],
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
    Size size = MediaQuery.of(context).size;
    var date = DateTime.now();
    var formattedDate = DateFormat('d MMM, yyyy').format(date).toString();
    print(date);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashBoard()),
              );
            },
            icon: Icon(Icons.arrow_back)),
        title: Center(
          child: Text(
            "Add a new note",
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$formattedDate",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _mainController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Start writing",
                ),
                style: TextStyle(
                  color: _fontColor,
                  fontSize: fontSize,
                  fontFamily: _fontFamily,
                  fontWeight: _newFontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            createPost().then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteEditorScreen()),
              ),
            );
          });
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.save,
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: _showFontTodoBottomSheet,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 198, 196, 196),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          height: 50,
          width: double.infinity,
          child: Icon(
            Icons.keyboard_double_arrow_up_rounded,
            size: 50,
            weight: 1.2,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
