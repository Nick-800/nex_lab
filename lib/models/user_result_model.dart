// To parse this JSON data, do
//
//     final userResultModel = userResultModelFromJson(jsonString);

import 'dart:convert';

UserResultModel userResultModelFromJson(String str) =>
    UserResultModel.fromJson(json.decode(str));

String userResultModelToJson(UserResultModel data) =>
    json.encode(data.toJson());

class UserResultModel {
  int id;
  int userId;
  int testId;
  String filePath;
  DateTime createdAt;
  DateTime updatedAt;

  UserResultModel({
    required this.id,
    required this.userId,
    required this.testId,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserResultModel.fromJson(Map<String, dynamic> json) =>
      UserResultModel(
        id: json["id"],
        userId: json["user_id"],
        testId: json["test_id"],
        filePath: json["file_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "test_id": testId,
        "file_path": filePath,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
