// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:esyryt_final_app/homePage.dart';

// class ProfilePicPage extends StatefulWidget {
//   TextEditingController? nameController;
//   // File? filename;
//   String? imageUrl;
//   ProfilePicPage({
//     Key? key,
//     this.nameController,
//     // this.filename,
//     this.imageUrl,
//   }) : super(key: key);

//   @override
//   State<ProfilePicPage> createState() => _ProfilePicPageState();
// }

// class _ProfilePicPageState extends State<ProfilePicPage> {
//   TextEditingController nameController = TextEditingController();
//   File? imageFile;
//   void selectImage(ImageSource source) async {
//     XFile? pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//       });
//       // cropImage(pickedFile);
//     }
//   }

//   void cropImage(XFile file) async {
//     CroppedFile? croppedImage = await ImageCropper().cropImage(
//       sourcePath: file.path,
//       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//       compressQuality: 20,
//     );
//     if (croppedImage != null) {
//       setState(() {
//         imageFile = File(croppedImage.path);
//       });
//     }
//   }

//   void showPhotoOption() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Upload Profile Picture"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   onTap: () {
//                     Navigator.pop(context);
//                     selectImage(ImageSource.gallery);
//                   },
//                   leading: Icon(Icons.photo_album),
//                   title: Text("Select from Gallery"),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     Navigator.pop(context);
//                     selectImage(ImageSource.camera);
//                   },
//                   leading: Icon(Icons.camera_alt),
//                   title: Text("Take a photo"),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   void checkvalue() {
//     String fullname = nameController.text.trim();
//     if (fullname == "" || imageFile == null) {
//       print("enter");
//       AlertDialog(
//         backgroundColor: Colors.red,
//         title: Text(
//           "please fill name and pic",
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     } else {
//       updateData();
//     }
//   }

//   void updateData() async {
//     //here do the storing task of photo and name into api
//     Navigator.popUntil(context, (route) => route.isFirst);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => HomePage(
//             // userModel: widget.userModel,
//             // firebaseUser: widget.firebaseUser,
//             ),
//         // share the image path to TodoScreen 1 or use provider for this
//       ),
//     );
//   }

//   final _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0xff6C6C6C),
//         // appBar: AppBar(
//         //   backgroundColor: Color(0xff6C6C6C),
//         //   title: Center(
//         //     child: Text(
//         //       "Complete Profile",
//         //       style: TextStyle(
//         //         fontFamily: "Google Sans",
//         //         fontWeight: FontWeight.bold,
//         //         fontSize: 28,
//         //         // color: Color.fromARGB(255, 4, 237, 245),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       showPhotoOption();
//                     },
//                     child: Container(
//                       // color: Colors.red,
//                       child: Center(
//                         child: CircleAvatar(
//                           radius: 80,
//                           backgroundImage: (imageFile != null)
//                               ? FileImage(imageFile!)
//                               : null,
//                           child: (imageFile == null)
//                               ? Icon(Icons.person, size: 60)
//                               : null,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.031,
//                     // height: 29,
//                   ),
//                   //Student Name
//                   TextFormField(
//                     keyboardType: TextInputType.name,
//                     controller: nameController,
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return "name cannot be empty";
//                       } else
//                         return null;
//                     },
//                     style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: Container(
//                           // height: 20,
//                           // width: 20,
//                           height: size.height * 0.020,
//                           width: size.width * 0.020,
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 3, horizontal: 3),
//                             child: Icon(
//                               Icons.person,
//                               color: Color(0xffFFFFFF),
//                             ),
//                           ),
//                         ),
//                       ),
//                       hintText: "Name",
//                       hintStyle: const TextStyle(
//                         fontFamily: "Google Sans",
//                         fontWeight: FontWeight.w400,
//                         fontSize: 16,
//                         color: Color(0xffFFFFFF),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.061,
//                     // height: 29,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if (_formkey.currentState!.validate()) {
//                         checkvalue();
//                       }
//                     },
//                     child: Center(
//                       child: Container(
//                         // height: 56,
//                         // width: 311,
//                         height: size.height * 0.065,
//                         width: size.width * 0.81,
//                         // color: Colors.red,
//                         child: Container(
//                           // height: 30,
//                           // width: 311,
//                           height: size.height * 0.036,
//                           width: size.width * 0.81,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(96),
//                             color: Color(0xff21C4A7),
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'SUBMIT',
//                               style: TextStyle(
//                                 color: Color(0xffFFFFFF),
//                                 fontSize: 20,
//                                 fontFamily: 'Poppins',
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  String imageUrl;
  String name;
  ProfilePage({
    Key? key,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imageFile;
  String? name;
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

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // cropImage(pickedFile);
      print(' this is path ${pickedFile!.path}');
    }
  }

  Future<String> updateDetails(File imageFile) async {
    try {
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      // path of updatepic
      var uri = Uri.parse(
          'https://notesapp-i6yf.onrender.com/user/auth/profileUpdate');
      var request = new http.MultipartRequest('PUT', uri);
      request.headers['Content-Type'] = 'application/json';
      request.headers['x-auth-token'] = token!;
      // request.fields['url'] = nameController.text.trim().toString();
      // request.fields['email'] = emailController.text.trim().toString();
      // request.fields['password'] = passwordcontroller.text.trim().toString();

      var multiport = new http.MultipartFile('profilePic', stream, length);

      request.files.add(multiport);

      var reponse = await request.send();
      print(reponse.statusCode);

      if (reponse.statusCode == 201) {
        print("hello");
        print(reponse.statusCode);
        print(reponse);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        return "pic uploded";
      } else {
        // print("hii");
        // print(reponse.statusCode);
        // print(reponse);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Updater'),
      ),
      body: Container(
        // color: Colors.red,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showPhotoOption();
              },
              child: ClipOval(
                child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        (imageFile != null) ? FileImage(imageFile!) : null,
                    // backgroundImage: NetworkImage(widget.imageUrl),
                    child: (imageFile == null)
                        ? Image.network(
                            widget.imageUrl,
                            height: 158,
                            width: 160,
                            fit: BoxFit.cover,
                          )
                        : null),
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.name,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (imageFile != null) {
                  print("imagefile is not null");
                  setState(() {
                    updateDetails(imageFile!);
                  });
                } else {
                  print("not uploded");
                }
              },
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
