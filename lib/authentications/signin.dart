import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:esyryt_final_app/authentications/finalSignUp.dart';
import 'package:esyryt_final_app/homePage.dart';
import 'package:esyryt_final_app/json/loginuser.dart';
import 'package:esyryt_final_app/services/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  static String id = "signInPage";
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _secureText = true;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var data;
  var userEmail, userPassword;
  bool isLoading = true;
  var dataResponse;
  var statusResponse;
  var messageResponse;

  var value;
  var token;
  void login({String? email, String? password}) async {
    isLoading
        ? showDialog(
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Text("");
    try {
      if (_formkey.currentState!.validate()) {
        var _userSignin = LoginUser(
          email: email,
          password: password,
        );
        var response = await context
            .read<AuthClient>()
            .postLogin('/user/auth/logIn', _userSignin);
        print(response);

        setState(() {
          data = response;
          value = jsonDecode(response);
          dataResponse = value;
          userEmail = value["data"]["email"];
          token = value["token"];
          print("token");
          print(token);

          print("userEmail::: $userEmail");
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        if (EmailValidator.validate(usernameController.text.trim())) {
          if (email == usernameController.text.trim()) {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  child: HomePage(),
                  type: PageTransitionType.fade,
                  isIos: true,
                  duration: Duration(milliseconds: 900),
                ),
                (route) => false);
          }
        } else {
          final text = "verify email and username again ";

          final snackBar = SnackBar(
              backgroundColor: Colors.blue,
              content: Text(
                text,
                style: TextStyle(color: Colors.white),
              ));
          ScaffoldMessenger.of(context).showSnackBar((snackBar));
        }
      }
    } catch (e) {
      // statusResponse = dataResponse["status"];
      messageResponse = dataResponse["message"];
      showDialog(
        context: context,
        builder: (context) => Center(
          child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 15, 1, 84),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (statusResponse != null)
                //   Text(
                //     "$statusResponse",
                //     style: TextStyle(
                //         fontWeight: FontWeight.w700,
                //         color: Color.fromARGB(255, 221, 9, 9),
                //         fontFamily: "Google Sans"),
                //   ),
                if (messageResponse != null)
                  Text(
                    "$messageResponse",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 232, 229, 229),
                        fontFamily: "Google Sans"),
                  ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = false;
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                        (route) => false,
                      );
                    });
                  },
                  child: Text("Ok"))
            ],
          ),
        ),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff6C6C6C),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                    // height: 35.46,
                  ),
                  Container(
                    height: size.height * 0.034,
                    width: size.height * 0.23,
                    // height: 26,
                    // width: 161,
                    // color: Colors.blue,
                    child: const Text(
                      "Welcome, Back",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.055,
                    // height: 50,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "email cannot be empty";
                          } else if (EmailValidator.validate(
                                  usernameController.text.trim()) ==
                              false) {
                            return "verify email and password again ";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              height: size.height * 0.020,
                              width: size.width * 0.020,
                              // height: 20,
                              // width: 20,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Icon(
                                  Icons.mail,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          hintText: "Username/Email/Phone number",
                          hintStyle: const TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.031,
                        // height: 29,
                      ),
                      // password
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "password cannot be empty";
                          else if (value.length < 8)
                            return "password must be atleast 8";
                          // else if (value != (passwordController.text)) {
                          //   final text = "verify password ";
                          //   final snackBar = SnackBar(content: Text(text));
                          //   ScaffoldMessenger.of(context).showSnackBar((snackBar));
                          //   return "verify email";
                          // }
                          else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              // height: 20,
                              // width: 20,
                              height: size.height * 0.020,
                              width: size.width * 0.020,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Icon(
                                  Icons.lock,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                              icon: _secureText
                                  ? const Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Color(0xffFFFFFF),
                                    )
                                  : const Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Color(0xffFFFFFF),
                                    )),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 11,
                  ),
                  // forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      // onTap: () => Navigator.pushNamed(
                      //   context,
                      //   ForgotPassword.id,
                      // ),
                      child: Container(
                        // height: 18,
                        // width: 113,
                        height: size.height * 0.021,
                        width: size.width * 0.30,
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF),
                              fontFamily: "Google Sans"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 28,
                    height: size.height * 0.029,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_formkey.currentState!.validate()) {
                          login(
                            email: usernameController.text.toString(),
                            password: passwordController.text.toString(),
                          );
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                        // height: 56,
                        // width: 311,
                        height: size.height * 0.065,
                        width: size.width * 0.81,
                        // color: Colors.red,
                        child: Container(
                          // height: 30,
                          // width: 311,
                          height: size.height * 0.036,
                          width: size.width * 0.81,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(96),
                            color: Color(0xff21C4A7),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 35,
                    height: size.height * 0.045,
                  ),
                  // divider or
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.36),
                        child: Container(
                          // height: 18,
                          // width: 15.91,
                          height: size.height * 0.021,
                          width: size.width * 0.036,
                          child: const Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    // height: 19,
                    height: size.height * 0.026,
                  ),
                  Center(
                    child: Container(
                      // height: 20,
                      // width: 228,
                      // color: Colors.green,
                      height: size.height * 0.031,
                      width: size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: 20,
                            // width: 172,
                            height: size.height * 0.025,
                            width: size.width * 0.45,
                            // color: Colors.green,
                            child: const Text(
                              "Don’t have an account ?",
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 15,
                                fontFamily: 'Google Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage())),
                            child: Container(
                              // height: 20,
                              // width: 56,
                              height: size.height * 0.028,
                              width: size.width * 0.189,
                              child: const Text(
                                "Sign up",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xffFFFFFF),
                                  fontSize: 16,
                                  fontFamily: 'Google Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 120,
                    height: size.height * 0.14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
