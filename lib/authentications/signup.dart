// import 'package:email_validator/email_validator.dart';
// import 'package:esyryt_final_app/authentications/signin.dart';
// import 'package:esyryt_final_app/homePage.dart';
// import 'package:esyryt_final_app/todo/dashBoard.dart';
// import 'package:esyryt_final_app/todoScreens/todoScreen1.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class SignUpPage extends StatefulWidget {
//   static String id = "signUpPage";

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   TextEditingController nameController = TextEditingController();
//   // TextEditingController phoneNumberController = TextEditingController();
//   // TextEditingController studentNameController = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   // TextEditingController conformpasswordcontroller = TextEditingController();
//   TextEditingController emailController = TextEditingController();

//   final _formkey = GlobalKey<FormState>();
//   bool _secureTextpass1 = true;
//   bool _secureTextpass2 = true;
//   bool _checkBox = false;

//   OnSignUpClick() async {
//     String name = nameController.text.trim();
//     String email = emailController.text.trim();
//     String password = passwordcontroller.text.trim();
//     // String cpassword = conformpasswordcontroller.text.trim();
//     // String phoneno = phoneNumberController.text.trim();
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => TodoScreen1(),
//         ));
//     //   if (_formkey.currentState!.validate()) {
//     //     UserCredential? credential;
//     //     try {
//     //       credential = await FirebaseAuth.instance
//     //           .createUserWithEmailAndPassword(email: email, password: password);
//     //     } on FirebaseAuthException catch (ex) {
//     //       UiHelper.alertDailogBox(
//     //           context, 'An error occured', '${ex.message.toString()}');
//     //       print(ex.code.toString());
//     //     }

//     //     if (credential != null) {
//     //       String uid = credential.user!.uid;
//     //       UserModel newUser = UserModel(
//     //         uid: uid,
//     //         email: email,
//     //         fullname: "",
//     //         profilepic: "",
//     //       );
//     //       await FirebaseFirestore.instance
//     //           .collection("users")
//     //           .doc(uid)
//     //           .set(newUser.toMap())
//     //           .then((value) => print("new user created"));
//     //       Navigator.popUntil(context, (route) => route.isFirst);
//     //       Navigator.pushReplacement(
//     //         context,
//     //         MaterialPageRoute(
//     //           builder: (context) => ProfilePicPage(
//     //               userModel: newUser, firebaseUser: credential!.user!),
//     //         ),
//     //       );
//     //     }
//     //   }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xff6C6C6C),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     // height: 55,
//                     height: size.height * 0.17,
//                   ),

//                   Container(
//                     height: 26,
//                     width: 80,
//                     // height: size.height * 0.036,
//                     // width: size.height * 0.80,
//                     // color: Colors.red,
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                           height: 1.2,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xffFFFFFF),
//                           fontFamily: "Google Sans"),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.018,
//                   ),
//                   Container(
//                     height: size.height * 0.024,
//                     width: size.height * 0.25,
//                     child: const Text(
//                       "Get started by creating account.",
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xffFFFFFF),
//                           fontFamily: "Google Sans"),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 34,
//                     height: size.height * 0.038,
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(
//                         // height: 30,
//                         height: size.height * 0.035,
//                       ),
//                       TextFormField(
//                         controller: nameController,
//                         // autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (String? value) {
//                           if (value!.isEmpty) {
//                             return "name cannot be empty";
//                           } else {
//                             return null;
//                           }
//                         },
//                         style: TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(right: 10.0),
//                             child: Container(
//                               height: size.height * 0.020,
//                               width: size.width * 0.020,
//                               // height: 20,
//                               // width: 20,
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 4, horizontal: 2),
//                                 child: Icon(
//                                   Icons.person,
//                                   color: Color(0xffFFFFFF),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           hintText: "Name",
//                           hintStyle: const TextStyle(
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Color(0xffFFFFFF),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.031,
//                         // height: 29,
//                       ),
//                       TextFormField(
//                         controller: emailController,
//                         // autovalidateMode: AutovalidateMode.onUserInteraction,
//                         validator: (String? value) {
//                           if (value!.isEmpty) {
//                             return "email cannot be empty";
//                           } else if (EmailValidator.validate(
//                                   emailController.text.trim()) ==
//                               false) {
//                             return "verify email again ";
//                           } else {
//                             return null;
//                           }
//                         },
//                         style: TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(right: 10.0),
//                             child: Container(
//                               height: size.height * 0.020,
//                               width: size.width * 0.020,
//                               // height: 20,
//                               // width: 20,
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 4, horizontal: 2),
//                                 child: Icon(
//                                   Icons.mail,
//                                   color: Color(0xffFFFFFF),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           hintText: "Email",
//                           hintStyle: const TextStyle(
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Color(0xffFFFFFF),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.031,
//                         // height: 29,
//                       ),
//                       // phone number
//                       // TextFormField(
//                       //   controller: phoneNumberController,
//                       //   keyboardType: TextInputType.number,
//                       //   validator: (String? value) {
//                       //     if (value!.isEmpty) {
//                       //       return "phoneNumber cannot be empty";
//                       //     } else if (value.length != 10)
//                       //       return 'Mobile Number must be of 10 digit';
//                       //     else
//                       //       return null;
//                       //   },
//                       //   style: TextStyle(color: Colors.white),
//                       //   decoration: InputDecoration(
//                       //     prefixIcon: Padding(
//                       //       padding: const EdgeInsets.only(right: 8.0),
//                       //       child: Container(
//                       //         // height: 20,
//                       //         // width: 20,
//                       //         height: size.height * 0.020,
//                       //         width: size.width * 0.020,
//                       //         child: const Padding(
//                       //           padding: EdgeInsets.symmetric(
//                       //               vertical: 3, horizontal: 3),
//                       //           child: Icon(
//                       //             Icons.lock,
//                       //             color: Color(0xffFFFFFF),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     hintText: "Phone Number",
//                       //     hintStyle: const TextStyle(
//                       //       fontFamily: "Google Sans",
//                       //       fontWeight: FontWeight.w200,
//                       //       fontSize: 16,
//                       //       color: Color(0xffFFFFFF),
//                       //     ),
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   // height: 30,
//                       //   height: size.height * 0.035,
//                       // ),
//                       TextFormField(
//                         controller: passwordcontroller,
//                         // keyboardType: TextInputType.visiblePassword,
//                         validator: (value) {
//                           if (value!.isEmpty)
//                             return "password cannot be empty";
//                           else if (value.length < 8)
//                             return "password must be atleast 8";
//                           else
//                             return null;
//                         },
//                         style: TextStyle(color: Colors.white),
//                         obscureText: _secureTextpass1,
//                         decoration: InputDecoration(
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.only(right: 10.0),
//                             child: Container(
//                               // height: 20,
//                               // width: 20,
//                               height: size.height * 0.020,
//                               width: size.width * 0.020,
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 4, horizontal: 2),
//                                 child: Icon(
//                                   Icons.lock,
//                                   color: Color(0xffFFFFFF),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _secureTextpass1 = !_secureTextpass1;
//                                 });
//                               },
//                               icon: _secureTextpass1
//                                   ? Icon(
//                                       CupertinoIcons.eye_slash_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )
//                                   : Icon(
//                                       CupertinoIcons.eye_fill,
//                                       color: Color(0xffFFFFFF),
//                                     )),
//                           hintText: "Enter Password",
//                           hintStyle: TextStyle(
//                             fontFamily: "Avenir",
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             color: Color(0xffFFFFFF),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         // height: 30,
//                         height: size.height * 0.035,
//                       ),
//                       // Conform password
//                       // TextFormField(
//                       //   controller: conformpasswordcontroller,
//                       //   validator: (value) {
//                       //     if (value!.isEmpty)
//                       //       return "password cannot be empty";
//                       //     else if (value.length < 8)
//                       //       return "password must be atleast 8";
//                       //     else if (value != passwordcontroller.text.trim())
//                       //       return "recheck the password ";
//                       //     else
//                       //       return null;
//                       //   },
//                       //   style: TextStyle(color: Colors.white),
//                       //   obscureText: _secureTextpass2,
//                       //   decoration: InputDecoration(
//                       //     prefixIcon: Padding(
//                       //       padding: const EdgeInsets.only(right: 10.0),
//                       //       child: Container(
//                       //         // height: 20,
//                       //         // width: 20,
//                       //         height: size.height * 0.020,
//                       //         width: size.width * 0.020,
//                       //         child: const Padding(
//                       //           padding: EdgeInsets.symmetric(
//                       //               vertical: 4, horizontal: 2),
//                       //           child: Icon(
//                       //             Icons.lock,
//                       //             color: Color(0xffFFFFFF),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     suffixIcon: IconButton(
//                       //         onPressed: () {
//                       //           setState(() {
//                       //             _secureTextpass2 = !_secureTextpass2;
//                       //           });
//                       //         },
//                       //         icon: _secureTextpass2
//                       //             ? const Icon(
//                       //                 CupertinoIcons.eye_slash_fill,
//                       //                 color: Color(0xffFFFFFF),
//                       //               )
//                       //             : const Icon(
//                       //                 CupertinoIcons.eye_fill,
//                       //                 color: Color(0xffFFFFFF),
//                       //               )),
//                       //     hintText: "Confirm Password",
//                       //     hintStyle: const TextStyle(
//                       //       fontFamily: "Avenir",
//                       //       fontWeight: FontWeight.w400,
//                       //       fontSize: 16,
//                       //       color: Color(0xffFFFFFF),
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),

//                   //
//                   SizedBox(
//                     // height: 28,
//                     height: size.height * 0.032,
//                   ),
//                   // Center(
//                   //   child: Container(
//                   //     // color: Colors.red,
//                   //     // height: 40,
//                   //     // width: 326,
//                   //     height: size.height * 0.052,
//                   //     width: size.width * 0.85,
//                   //     child: Row(
//                   //       children: [
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     setState(() {
//                   //       _checkBox = !_checkBox;
//                   //     });
//                   //   },
//                   //   child: Container(
//                   //     // color: _checkBox ? Colors.green : Colors.black,
//                   //     color: Colors.black,
//                   //     height: 24,
//                   //     width: 24,
//                   //     // height: size.height * 0.024,
//                   //     // width: size.width * 0.026,
//                   //     child: _checkBox
//                   //         ? Icon(
//                   //             Icons.check,
//                   //             color: Colors.green,
//                   //           )
//                   //         : Icon(
//                   //             Icons.square_outlined,
//                   //             color: Colors.white,
//                   //           ),
//                   //   ),
//                   // ),
//                   // SizedBox(
//                   //   // width: 8,
//                   //   width: size.width * 0.02,
//                   // ),
//                   // Container(
//                   //   // color: Colors.red,
//                   //   // height: 40,
//                   //   // width: 290,
//                   //   height: size.height * 0.045,
//                   //   width: size.width * 0.76,
//                   //   child: Center(
//                   //     child: Text.rich(TextSpan(
//                   //       text:
//                   //           "By clicking continue, you agress to our ",
//                   //       style: const TextStyle(
//                   //         color: Color(0xffFFFFFF),
//                   //         fontSize: 12,
//                   //         fontFamily: 'Google Sans',
//                   //         fontWeight: FontWeight.w400,
//                   //       ),
//                   //       children: [
//                   //         TextSpan(
//                   //           text: "Terms and Conditions",
//                   //           // recognizer: TapGestureRecognizer()
//                   //           //   ..onTap = () {
//                   //           //     // navigate to certain page
//                   //           //   },
//                   //           style: TextStyle(
//                   //             decoration: TextDecoration.underline,
//                   //           ),
//                   //         ),
//                   //         TextSpan(
//                   //           text: " and the",
//                   //         ),
//                   //         TextSpan(
//                   //           text: " Privacy Policy.",
//                   //           // recognizer: TapGestureRecognizer()
//                   //           //   ..onTap = () {
//                   //           //     // navigate to certain page
//                   //           //   },
//                   //           style: TextStyle(
//                   //             decoration: TextDecoration.underline,
//                   //           ),
//                   //         ),
//                   //       ],
//                   //     )),
//                   //   ),
//                   // ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   SizedBox(
//                     // height: 25,
//                     height: size.height * 0.030,
//                   ),
//                   // signUp
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (_formkey.currentState!.validate()) {
//                           OnSignUpClick();
//                         }
//                       });
//                     },
//                     child: Center(
//                       child: Container(
//                         // height: 56,
//                         // width: 311,
//                         height: size.height * 0.069,
//                         width: size.width * 0.81,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(96),
//                           color: Color.fromARGB(255, 174, 177, 177),
//                         ),
//                         child: Center(
//                           child: Container(
//                             // color: Colors.red,
//                             height: 30,
//                             width: 311,
//                             child: const Center(
//                               child: Text(
//                                 'SIGN UP',
//                                 style: TextStyle(
//                                   color: Color(0xffFFFFFF),
//                                   fontSize: 20,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     // height: 25,
//                     height: size.height * 0.030,
//                   ),
//                   //Already have an account ?
//                   Center(
//                     child: Container(
//                       // height: 20,
//                       // width: 242,
//                       // color: Colors.green,
//                       height: size.height * 0.037,
//                       width: size.width * 0.65,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Already have an account ?",
//                             style: TextStyle(
//                               color: Color(0xffFFFFFF),
//                               fontSize: 15,
//                               fontFamily: 'Google Sans',
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignIn())),
//                             child: Container(
//                               // height: 20,
//                               // width: 50,
//                               height: size.height * 0.025,
//                               width: size.width * 0.163,
//                               child: const Text(
//                                 "Sign in",
//                                 style: TextStyle(
//                                   decoration: TextDecoration.underline,
//                                   color: Color(0xffFFFFFF),
//                                   fontSize: 16,
//                                   fontFamily: 'Google Sans',
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   SizedBox(
//                     height: size.height * 0.09,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
