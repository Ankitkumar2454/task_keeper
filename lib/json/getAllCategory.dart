// To parse this JSON data, do
//
//     final getAllTodoCategory = getAllTodoCategoryFromJson(jsonString);

import 'dart:convert';

GetAllTodoCategory getAllTodoCategoryFromJson(String str) =>
    GetAllTodoCategory.fromJson(json.decode(str));

String getAllTodoCategoryToJson(GetAllTodoCategory data) =>
    json.encode(data.toJson());

class GetAllTodoCategory {
  String category;

  GetAllTodoCategory({
    required this.category,
  });

  factory GetAllTodoCategory.fromJson(Map<String, dynamic> json) =>
      GetAllTodoCategory(
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
      };
}
