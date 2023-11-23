// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  String email;
  String password;
  ProfilePic profilePic;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        profilePic: ProfilePic.fromJson(json["profilePic"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "profilePic": profilePic.toJson(),
      };
}

class ProfilePic {
  String filename;
  String url;

  ProfilePic({
    required this.filename,
    required this.url,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        filename: json["filename"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "url": url,
      };
}
