// To parse this JSON data, do
//
//     final getProfile = getProfileFromJson(jsonString);

import 'dart:convert';

GetProfile getProfileFromJson(String str) =>
    GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
  bool status;
  String message;
  Data data;

  GetProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  ProfilePic profilePic;
  String id;
  String name;
  String email;
  String password;
  bool isVerified;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.profilePic,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.isVerified,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profilePic: ProfilePic.fromJson(json["profilePic"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        isVerified: json["isVerified"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "profilePic": profilePic.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "isVerified": isVerified,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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
