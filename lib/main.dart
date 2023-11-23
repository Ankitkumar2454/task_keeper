import 'package:esyryt_final_app/animated_starting/onboarding_screen.dart';
import 'package:esyryt_final_app/authentications/finalSignUp.dart';
import 'package:esyryt_final_app/authentications/profilePage.dart';
import 'package:esyryt_final_app/authentications/signin.dart';
import 'package:esyryt_final_app/diary/DairyHomeScreen.dart';
import 'package:esyryt_final_app/diary/DiaryScreen10.dart';
import 'package:esyryt_final_app/helper/dropDown.dart';
import 'package:esyryt_final_app/homePage.dart';
import 'package:esyryt_final_app/notesScreen/NoteAttachmentScreen3.dart';
import 'package:esyryt_final_app/notesScreen/NoteScreen1.dart';
import 'package:esyryt_final_app/notesScreen/NoteTextScreen2.dart';
import 'package:esyryt_final_app/notesScreen/NoteScreen4.dart';
import 'package:esyryt_final_app/notesScreen/NoteAudioScreen5.dart';
import 'package:esyryt_final_app/notesScreen/NoteCameraScreen6.dart';
import 'package:esyryt_final_app/notesScreen/signaturePage.dart';
import 'package:esyryt_final_app/services/client.dart';
import 'package:esyryt_final_app/startingPage/IntroDiaryPage.dart';
import 'package:esyryt_final_app/startingPage/introNotePage.dart';
import 'package:esyryt_final_app/startingPage/introductoryPage.dart';
import 'package:esyryt_final_app/startingPage/startingPage.dart';
import 'package:esyryt_final_app/testing.dart';
import 'package:esyryt_final_app/todo/dashBoard.dart';
import 'package:esyryt_final_app/todo/noteEditor.dart';
import 'package:esyryt_final_app/todo/noteReader.dart';
import 'package:esyryt_final_app/todoScreens/taskHistory.dart';
import 'package:esyryt_final_app/todoScreens/todoScreen1.dart';
import 'package:esyryt_final_app/todoScreens/todoTestScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthClient(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      return HomePage();
    }
    return OnboardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: checkLogin(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Widget;
          } else {
            return Scaffold(
                body: const Center(child: CircularProgressIndicator()));
          }
        },
      ),
      // home: MyHomePage(),
    );
  }
}
