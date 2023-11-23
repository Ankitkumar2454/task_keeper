import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class NoteScreen5 extends StatefulWidget {
  const NoteScreen5({Key? key}) : super(key: key);

  @override
  _NoteScreen5State createState() => _NoteScreen5State();
}

// audio screen
class _NoteScreen5State extends State<NoteScreen5> {
  TextEditingController titleController = TextEditingController();
  TextEditingController writingController = TextEditingController();
  final recorder = FlutterSoundRecorder();
  final player = FlutterSoundPlayer();
  // late AudioPlayer _audioPlayer;
  bool isRecordReady = false;
  // Flag to track whether the keyboard is open
  bool isKeyboardOpen = false;
  bool isbold = false;
  bool isitalic = false;
  bool isunderline = false;
  String? selectedText;
  bool playingStopped = false;
  Future<void> record() async {
    print("do here start");
    if (!isRecordReady) return;
    try {
      await recorder.startRecorder(
        toFile: 'audio',
      );
    } catch (e) {
      print("Error starting recorder: $e");
    }
  }

  Future<void> stop() async {
    if (!isRecordReady) return;

    try {
      final path = await recorder.stopRecorder();
      final audioFile = File(path!);
      print("Recorded audio path: $audioFile");
    } catch (e) {
      print("Error stopping recorder: $e");
    }
  }

  double _sliderValue = 0.0;
  Duration _duration = Duration();
  late Timer _progressTimer;
  String fileName = "";
  int fileSize = 0;
  double fileSizeInKB = 0.0;
  Future<void> play() async {
    try {
      String filePath = '/data/user/0/com.example.esyryt_final_app/cache/audio';
      // Extracting file name and size
      File audioFile = File(filePath);
      setState(() {});
      fileName = basename(audioFile.path);
      fileSize = audioFile.lengthSync();
      int fileSizeInBytes = await audioFile.length();
      fileSizeInKB = fileSizeInBytes / 1024;

      print("File Name: ${fileName}");
      print("File Size: ${fileSize} bytes");

      await player.startPlayer(
        fromURI: filePath,
        whenFinished: () {
          setState(() {
            playpause = false;
          });
        },
      );
      // _progressTimer =
      //     Timer.periodic(Duration(milliseconds: 100), (timer) async {
      //   var info = await player.playerState();
      //   if (info != null && info.duration != null) {
      //     setState(() {
      //       _duration = info.duration;
      //       _sliderValue = info.position / info.duration.inMilliseconds;
      //     });
      //   }
      // });
      print("");
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> stopPlayback() async {
    try {
      await player.stopPlayer();
    } catch (e) {
      print("Error stopping audio playback: $e");
    }
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
    super.dispose();
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone Permission not granted';
    }

    try {
      await recorder.openRecorder();
      isRecordReady = true;
      recorder.setSubscriptionDuration(Duration(milliseconds: 500));
    } catch (e) {
      print("Error initializing recorder: $e");
    }
  }

  Future<void> initPlayer() async {
    try {
      await player.openPlayer();
      player.setSubscriptionDuration(Duration(milliseconds: 100));
    } catch (e) {
      print("Error initializing player: $e");
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    initRecorder();
    initPlayer();

    // Listen for changes in the keyboard state
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final focusNode = FocusScope.of(_scaffoldKey.currentContext!);
      focusNode.addListener(() {
        setState(() {
          isKeyboardOpen = focusNode.hasFocus;
        });
      });
    });
  }

  bool playpause = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
                ],
              ),
            ),
            if (isKeyboardOpen)
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 348,
                        height: 37,
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            // color: Color.fromARGB(255, 235, 24, 24),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0.2,
                                offset: Offset(1, 0),
                              )
                            ]),
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            if (playingStopped == true)
              Positioned(
                top: 350,
                left: 25,
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      width: 355,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.5), // Box shadow color
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset:
                                Offset(0, 3), // Offset in x and y directions
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  playpause = true;
                                });

                                await play();
                              },
                              child: (playpause == true)
                                  ? Icon(Icons.pause)
                                  : Image.asset(
                                      'assets/noteScreensAll/Group 328.png',
                                    ),
                            ),
                            Text("$fileName"),
                            Text(
                              "${fileSizeInKB.round()} kb",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Slider(
                    //   value: _sliderValue,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _sliderValue = value;
                    //     });
                    //   },
                    // ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     if (playpause) {
                    //       await pause();
                    //     } else {
                    //       await play();
                    //     }
                    //     setState(() {
                    //       playpause = !playpause;
                    //     });
                    //   },
                    //   child: Text(playpause ? 'Pause' : 'Play'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     await stop();
                    //     setState(() {
                    //       playpause = false;
                    //       _sliderValue = 0.0;
                    //     });
                    //   },
                    //   child: Text('Stop'),
                    // ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 56.0,
        ),
        child: Container(
          height: 35,
          width: 355,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Image.asset(
                  'assets/NoteScreen1/Group329.png',
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await stopPlayback();
                  //   },
                  //   child: Text(
                  //     'Stop',
                  //     style: TextStyle(fontSize: 12),
                  //   ),
                  // ),
                  // Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 150.0, right: 80, top: 6),
                    child: StreamBuilder<RecordingDisposition>(
                      stream: recorder.onProgress,
                      builder: (context, snapshot) {
                        final duration = snapshot.hasData
                            ? snapshot.data!.duration
                            : Duration.zero;
                        final formattedDuration =
                            '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

                        return Text(
                          '${formattedDuration}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 300,
                top: -5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      width: 1.0, // Adjust the border width as needed
                      color: Colors.black, // Adjust the border color as needed
                    ),
                  ),
                  onPressed: () async {
                    if (recorder.isRecording) {
                      await stop();
                      playingStopped = true;
                    } else {
                      await record();
                      playingStopped = false;
                    }
                    setState(() {});
                  },
                  child: Icon(
                    recorder.isRecording ? Icons.stop : Icons.mic,
                    color: const Color.fromARGB(255, 110, 109, 109),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
