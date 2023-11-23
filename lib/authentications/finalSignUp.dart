import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:esyryt_final_app/authentications/profilePage.dart';
import 'package:esyryt_final_app/authentications/signin.dart';
import 'package:esyryt_final_app/homePage.dart';
import 'package:esyryt_final_app/json/register.dart';
import 'package:esyryt_final_app/services/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  static String id = "signUpPage";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  File? imageFile;
  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // cropImage(pickedFile);
      print(' this is path ${imageFile!.path}');
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();

      // path of signup
      var uri =
          Uri.parse('https://notesapp-i6yf.onrender.com/user/auth/signUp');
      var request = new http.MultipartRequest('POST', uri);
      request.headers['Content-Type'] = 'application/json';
      request.fields['name'] = nameController.text.trim().toString();
      request.fields['email'] = emailController.text.trim().toString();
      request.fields['password'] = passwordcontroller.text.trim().toString();

      var multiport = new http.MultipartFile('profilePic', stream, length);

      request.files.add(multiport);

      var reponse = await request.send();
      print(reponse.statusCode);
      // print(reponse.);

      if (reponse.statusCode == 201) {
        print("hello");
        print(reponse.statusCode);
        print(reponse);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return "pic uploded";
      } else {
        print("hii");
        print(reponse.statusCode);
        print(reponse);
        print(await reponse.stream.bytesToString());
        return "${reponse.statusCode}Failed";
      }
      //
    } catch (e) {
      print(e);
      print("failed");
      return "$e";
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20,
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  void showPhotoOption() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: Icon(Icons.photo_album),
                  title: Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  bool _secureTextpass1 = true;
  bool _secureTextpass2 = true;
  bool _checkBox = false;
  bool isLoading = true;

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
                    // height: 55,
                    height: size.height * 0.032,
                  ),
                  GestureDetector(
                    onTap: () {
                      showPhotoOption();
                    },
                    child: Container(
                      // color: Colors.red,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 214, 216, 214),
                          radius: 60,
                          backgroundImage: (imageFile != null)
                              ? FileImage(imageFile!)
                              : null,
                          child: (imageFile == null)
                              ? Icon(Icons.person, size: 60)
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // height: 55,
                    height: size.height * 0.032,
                  ),
                  Container(
                    // height: 26,
                    // width: 80,
                    height: size.height * 0.036,
                    width: size.height * 0.80,
                    // color: Colors.red,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    // height: 16,
                    height: size.height * 0.018,
                  ),
                  Container(
                    // height: 20,
                    // width: 194,
                    height: size.height * 0.024,
                    width: size.height * 0.25,
                    // color: Colors.red,
                    child: const Text(
                      "Get started by creating account.",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFFFF),
                          fontFamily: "Google Sans"),
                    ),
                  ),
                  SizedBox(
                    // height: 34,
                    height: size.height * 0.038,
                  ),

                  Column(
                    children: [
                      SizedBox(
                        // height: 30,
                        height: size.height * 0.035,
                      ),
                      TextFormField(
                        controller: nameController,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "name cannot be empty";
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
                                  Icons.person,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          hintText: "Name",
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
                      TextFormField(
                        controller: emailController,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "email cannot be empty";
                          } else if (EmailValidator.validate(
                                  emailController.text.trim()) ==
                              false) {
                            return "verify email again ";
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
                          hintText: "Email",
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
                      TextFormField(
                        controller: passwordcontroller,
                        // keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "password cannot be empty";
                          else if (value.length < 8)
                            return "password must be atleast 8";
                          else
                            return null;
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: _secureTextpass1,
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
                                  _secureTextpass1 = !_secureTextpass1;
                                });
                              },
                              icon: _secureTextpass1
                                  ? Icon(
                                      CupertinoIcons.eye_slash_fill,
                                      color: Color(0xffFFFFFF),
                                    )
                                  : Icon(
                                      CupertinoIcons.eye_fill,
                                      color: Color(0xffFFFFFF),
                                    )),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                      SizedBox(
                        // height: 30,
                        height: size.height * 0.035,
                      ),
                      // Conform password
                      // TextFormField(
                      //   controller: conformpasswordcontroller,
                      //   validator: (value) {
                      //     if (value!.isEmpty)
                      //       return "password cannot be empty";
                      //     else if (value.length < 8)
                      //       return "password must be atleast 8";
                      //     else if (value != passwordcontroller.text.trim())
                      //       return "recheck the password ";
                      //     else
                      //       return null;
                      //   },
                      //   style: TextStyle(color: Colors.white),
                      //   obscureText: _secureTextpass2,
                      //   decoration: InputDecoration(
                      //     prefixIcon: Padding(
                      //       padding: const EdgeInsets.only(right: 10.0),
                      //       child: Container(
                      //         // height: 20,
                      //         // width: 20,
                      //         height: size.height * 0.020,
                      //         width: size.width * 0.020,
                      //         child: const Padding(
                      //           padding: EdgeInsets.symmetric(
                      //               vertical: 4, horizontal: 2),
                      //           child: Icon(
                      //             Icons.lock,
                      //             color: Color(0xffFFFFFF),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     suffixIcon: IconButton(
                      //         onPressed: () {
                      //           setState(() {
                      //             _secureTextpass2 = !_secureTextpass2;
                      //           });
                      //         },
                      //         icon: _secureTextpass2
                      //             ? const Icon(
                      //                 CupertinoIcons.eye_slash_fill,
                      //                 color: Color(0xffFFFFFF),
                      //               )
                      //             : const Icon(
                      //                 CupertinoIcons.eye_fill,
                      //                 color: Color(0xffFFFFFF),
                      //               )),
                      //     hintText: "Confirm Password",
                      //     hintStyle: const TextStyle(
                      //       fontFamily: "Avenir",
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 16,
                      //       color: Color(0xffFFFFFF),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  SizedBox(
                    // height: 28,
                    height: size.height * 0.032,
                  ),
                  // next

                  // submit and the lofin to todoScreen1 page
                  // signUp
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_formkey.currentState!.validate()) {
                          if (imageFile != null) {
                            uploadImage(imageFile!);
                          } else {
                            print("not uploded");
                          }
                        }
                      });
                    },
                    child: Center(
                      child: Container(
                        // height: 56,
                        // width: 311,
                        height: size.height * 0.069,
                        width: size.width * 0.81,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(96),
                          color: Color(0xff21C4A7),
                        ),
                        child: Center(
                          child: Container(
                            // color: Colors.red,
                            height: 30,
                            width: 311,
                            child: const Center(
                              child: Text(
                                'SIGN UP',
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
                  ),
                  SizedBox(
                    // height: 25,
                    height: size.height * 0.030,
                  ),
                  //next
                  // Center(
                  //   child: Container(
                  //     // height: 56,
                  //     // width: 311,
                  //     height: size.height * 0.065,
                  //     width: size.width * 0.81,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         nextSignUpPage();
                  //       },
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(96),
                  //           color: Color.fromARGB(255, 88, 89, 89),
                  //         ),
                  //         child: Center(
                  //           child: Container(
                  //             // height: 30,
                  //             // width: 311,
                  //             height: size.height * 0.030,
                  //             width: size.width * 0.81,
                  //             child: const Center(
                  //               child: Text(
                  //                 'Next',
                  //                 style: TextStyle(
                  //                   color: Color(0xffFFFFFF),
                  //                   fontSize: 20,
                  //                   fontFamily: 'Poppins',
                  //                   fontWeight: FontWeight.w400,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    // height: 25,
                    height: size.height * 0.030,
                  ),
                  //Already have an account ?
                  Center(
                    child: Container(
                      // height: 20,
                      // width: 242,
                      // color: Colors.green,
                      height: size.height * 0.037,
                      width: size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account ?",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 15,
                              fontFamily: 'Google Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn())),
                            child: Container(
                              // height: 20,
                              // width: 50,
                              height: size.height * 0.025,
                              width: size.width * 0.163,
                              child: const Text(
                                "Sign in",
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
                    // height: 100,
                    height: size.height * 0.150,
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
