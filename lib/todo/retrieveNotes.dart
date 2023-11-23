import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  bool status;
  List<Datum> data;

  Notes({
    required this.status,
    required this.data,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String title;
  String description;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<Attachment> attachment;

  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.attachment,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        attachment: List<Attachment>.from(
            json["attachment"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "attachment": List<dynamic>.from(attachment.map((x) => x.toJson())),
      };
}

class Attachment {
  String publicId;
  String url;
  String id;

  Attachment({
    required this.publicId,
    required this.url,
    required this.id,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        publicId: json["public_Id"],
        url: json["url"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "public_Id": publicId,
        "url": url,
        "_id": id,
      };
}
