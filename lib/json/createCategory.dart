
// To parse this JSON data, do
//
//     final createCategory = createCategoryFromJson(jsonString);

import 'dart:convert';

CreateCategory createCategoryFromJson(String str) => CreateCategory.fromJson(json.decode(str));

String createCategoryToJson(CreateCategory data) => json.encode(data.toJson());

class CreateCategory {
    String category;

    CreateCategory({
        required this.category,
    });

    factory CreateCategory.fromJson(Map<String, dynamic> json) => CreateCategory(
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
    };
}
