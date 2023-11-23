import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import "package:universal_html/html.dart" show AnchorElement;
import 'package:form_field_validator/form_field_validator.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  bool isKeyboardOpen = false;
  bool isDrawingMode = false;
  bool isbold = false;
  bool isitalic = false;
  bool isunderline = false;
  File? selectedImage;
  String? selectedText;
  int _selectedIndex = 0;
  Color selectedColor = Colors.black;
  double eraserSize = 20.0; // Default eraser size
  double strokeWidth = 5;
  bool isErasing = false;

  // List<DrawingPoint> drawingPoints = [];
  List<Color> colors = [
    Color(0xffFF0101),
    Color(0xff8FFF01),
    Color(0xff05FFC3),
    Color(0xff01D1FF),
    Color(0xff9E01FF)
  ];
  Color selectedBackgroundColor = Color(0xFF9D85DC).withOpacity(0.6);

  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  File _selectedFile = File('');
  String _enteredTitle = '';
  String _enteredDescription = '';
  final title = TextEditingController();
  final description = TextEditingController();
  Color _selectedStrokeColor = Colors.white;
  Color _selectedCanvasColor = Color.fromARGB(255, 224, 218, 218);

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Stroke Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedStrokeColor,
              onColorChanged: (Color color) {
                setState(() {
                  if (_selectedIndex == 2) {
                    _selectedStrokeColor = _selectedCanvasColor;
                  } else {
                    _selectedStrokeColor = color;
                  }
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _clearCanvas() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard Canvas'),
          content: const Text(
              'Do you want to discard the current canvas and start over?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => const WelcomeScreen(),
                //   ),
                // );
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _signaturePadKey.currentState!.clear();
                title.clear(); // Clear the title field
                description.clear(); // Clear the description field
                _enteredTitle = '';
                _enteredDescription = '';
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => const WelcomeScreen(),
                //   ),
                // );
              },
            ),
          ],
        );
      },
    );
  }

  void _showCanvasColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Canvas Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedCanvasColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedCanvasColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var _penstrokewidth = 2.4;

  void updateFontSize(double newSize) {
    setState(() {
      _selectedIndex = 2;
      _penstrokewidth = newSize;
      _selectedStrokeColor = _selectedCanvasColor;
    });
  }

  // void updateEraserSize(double newSize) {
  //   setState(() {
  //     _penstrokewidth = newSize;
  //   });
  // }

  void eraserOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Text("Size:"),
                        Container(
                          width: 250,
                          child: Slider(
                            min: 0,
                            max: 10,
                            value: _penstrokewidth,
                            onChanged: (val) {
                              updateFontSize(val);
                              setState(() {
                                _selectedStrokeColor = _selectedCanvasColor;
                                _selectedIndex = 2;
                                _penstrokewidth = val;
                                print(val);
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 29,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          child: Text("${_penstrokewidth.round()}"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void openPenOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 225,
              child: Column(
                children: <Widget>[
                  // Show only when not in Eraser mode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: List.generate(
                          colors.length,
                          (index) => _buildColorChose(colors[index]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            openColorPickerForDraw(context);
                          });
                        },
                        child: Image.asset('assets/3notescreen/Group 305.png'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Text("Size:"),
                        Container(
                          width: 250,
                          child: Slider(
                            min: 0,
                            max: 10,
                            value: _penstrokewidth,
                            onChanged: (val) {
                              updateFontSize(val);
                              setState(() {
                                _penstrokewidth = val;
                                print(val);
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 29,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          child: Text("${_penstrokewidth.round()}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: const ui.Color.fromARGB(221, 126, 124, 124),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            updateFontSize(2);
                          },
                          child: Container(
                              height: 49,
                              width: 59,
                              color: Colors.white,
                              child: Image.asset(
                                  'assets/noteScreensAll/Group 297.png')),
                        ),
                        InkWell(
                          onTap: () {
                            updateFontSize(4);
                          },
                          child: Container(
                            height: 49,
                            width: 59,
                            child: Image.asset(
                                'assets/noteScreensAll/Group 298.png'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            updateFontSize(6);
                          },
                          child: Container(
                              height: 49,
                              width: 59,
                              child: Image.asset(
                                  'assets/noteScreensAll/Group 299.png')),
                        ),
                        InkWell(
                          onTap: () {
                            updateFontSize(9);
                          },
                          child: Container(
                              height: 49,
                              width: 59,
                              child: Image.asset(
                                'assets/noteScreensAll/Group 300.png',
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void openColorPickerForDraw(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedStrokeColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedStrokeColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveImage() async {
    // ui.Image data =
    //     await _signaturePadKey.currentState!.toImage(pixelRatio: 2.0);
    // final byteData = await data.toByteData(format: ui.ImageByteFormat.png);
    // final Uint8List imageBytes = byteData!.buffer
    //     .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

    // if (kIsWeb) {
    //   AnchorElement(
    //     href:
    //         'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(imageBytes)}',
    //   )
    //     ..setAttribute('download', 'Output.png')
    //     ..click();
    // } else {
    //   final String path = (await getApplicationSupportDirectory()).path;
    //   final String fileName =
    //       Platform.isWindows ? '$path\\Output.png' : '$path/Output.png';
    //   final File file = File(fileName);
    //   _selectedFile = file;
    //   await file.writeAsBytes(imageBytes, flush: true);
    //   OpenFile.open(fileName);
    // }

    // print('Started uploading');
    // _enteredTitle = title.text;
    // _enteredDescription = description.text;

    // final url = Uri.https('notesapp-i6yf.onrender.com', '/user/createNotes');
    // await http.post(
    //   url,
    //   headers: {'Content-type': 'application/json'},
    //   body: json.encode(
    //     {
    //       'title': _enteredTitle,
    //       'description': _enteredDescription,
    //       'attachment': _selectedFile.path,
    //     },
    //   ),
    // );
    // print(_enteredTitle);
    // print(_enteredDescription);
    // print(_selectedFile);
    // print('It\'s done');
    print("image saved ");
  }
List<Offset> points = [];
  @override
  Widget build(BuildContext context) {
    print("penstroke" + _penstrokewidth.toString());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    Spacer(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) => StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  Container(
                                height: 260,
                                color: Colors.white,
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
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        const Color(0xffffffff),
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
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 550,
                  width: 300,
                  child: SfSignaturePad(
                    key: _signaturePadKey,
                    backgroundColor: _selectedCanvasColor,
                    strokeColor: _selectedStrokeColor,
                    // minimumStrokeWidth: 2.0,
                    minimumStrokeWidth: _penstrokewidth,
                    maximumStrokeWidth: 4.0,
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         _showColorPicker(context);
              //       },
              //       child: const Column(
              //         children: [
              //           Icon(Icons.palette),
              //           Text('Pen Color'),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     InkWell(
              //       onTap: () {
              //         _signaturePadKey.currentState!.clear();
              //       },
              //       child: const Column(
              //         children: [
              //           Icon(Icons.brush),
              //           Text('Clear'),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(width: 30),
              //     InkWell(
              //       onTap: _saveImage,
              //       child: const Column(
              //         children: [
              //           Icon(Icons.save),
              //           Text('Save'),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     InkWell(
              //       onTap: () {
              //         _showCanvasColorPicker(context);
              //       },
              //       child: const Column(
              //         children: [
              //           Icon(Icons.format_paint),
              //           Text('Canvas Color'),
              //         ],
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _clearCanvas,
        //   tooltip: 'New Canvas',
        //   child: const Icon(Icons.add),
        // ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: InkWell(
                      onTap: () {
                        openPenOptions(context);
                      },
                      child: Image.asset('assets/3notescreen/Pen tool.png')),
                  label: 'Pen',
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      _showCanvasColorPicker(context);
                    },
                    child: Image.asset(
                      'assets/3notescreen/Group 290.png',
                    ),
                  ),
                  label: 'Background',
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                      onTap: () {
                        setState(() {
                          // _selectedIndex = 2; // Select Eraser
                          // openPenOptions(context); // Open eraser size options
                          eraserOption(context);
                        });
                      },
                      child: Image.asset('assets/3notescreen/Eraser.png')),
                  label: 'Eraser',
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                      onTap: () {
                        _signaturePadKey.currentState!.clear();
                      },
                      child: Image.asset('assets/3notescreen/Clean.png')),
                  label: 'All Clear',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xFF6C6C6C),
              unselectedItemColor: Colors.black45,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              // onTap: (int index) {
              //   setState(() {
              //     _selectedIndex = index;
              //     if (index == 0) {
              //       isDrawingMode = true;
              //       isErasing =
              //           false; // Disable eraser mode when switching to Pen mode
              //       openPenOptions(context);
              //     } else if (index == 2) {
              //       // Eraser
              //       toggleErasing(); // Toggle eraser mode
              //       if (isErasing) {
              //         selectedColor = selectedBackgroundColor.withOpacity(
              //             0.6); // Set erase color to background color
              //       }
              //     } else {
              //       isDrawingMode = false;
              //     }
              //     if (index == 1) {
              //       openColorPicker(context);
              //     }
              // });
              // },
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () {},
          child: Image.asset(
            'assets/noteScreensAll/Group 208.png',
          ),
        ),
      ),
    );
  }

  Widget _buildColorChose(Color color) {
    bool isSelected = selectedColor == color;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () => setState(() => selectedColor = color),
        child: Container(
          height: isSelected ? 47 : 40,
          width: isSelected ? 47 : 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border:
                isSelected ? Border.all(color: Colors.white, width: 3) : null,
          ),
        ),
      ),
    );
  }
}
