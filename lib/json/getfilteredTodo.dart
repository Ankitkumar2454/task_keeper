// To parse this JSON data, do
//
//     final getTodoFiltered = getTodoFilteredFromJson(jsonString);

import 'dart:convert';

GetTodoFiltered getTodoFilteredFromJson(String str) =>
    GetTodoFiltered.fromJson(json.decode(str));

String getTodoFilteredToJson(GetTodoFiltered data) =>
    json.encode(data.toJson());

class GetTodoFiltered {
  String id;
  String userId;
  String title;
  String? description;
  String category;
  String priority;
  DateTime dueDate;
  bool completed;
  List<Attachment> attachments;

  GetTodoFiltered({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    required this.completed,
    required this.attachments,
  });

  factory GetTodoFiltered.fromJson(Map<String, dynamic> json) =>
      GetTodoFiltered(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        priority: json["priority"],
        dueDate: DateTime.parse(json["dueDate"]),
        completed: json["completed"],
        attachments: List<Attachment>.from(
            json["attachments"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "category": category,
        "priority": priority,
        "dueDate": dueDate.toIso8601String(),
        "completed": completed,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
      };
}

class Attachment {
  String filename;
  String url;
  String id;

  Attachment({
    required this.filename,
    required this.url,
    required this.id,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        filename: json["filename"],
        url: json["url"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "url": url,
        "_id": id,
      };
}
