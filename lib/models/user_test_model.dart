// To parse this JSON data, do
//
//     final userTestModel = userTestModelFromJson(jsonString);

import 'dart:convert';

UserTestModel userTestModelFromJson(String str) =>
    UserTestModel.fromJson(json.decode(str));

String userTestModelToJson(UserTestModel data) => json.encode(data.toJson());

class UserTestModel {
  int id;
  int userId;
  int testId;
  DateTime createdAt;
  DateTime updatedAt;

  UserTestModel({
    required this.id,
    required this.userId,
    required this.testId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserTestModel.fromJson(Map<String, dynamic> json) => UserTestModel(
        id: json["id"],
        userId: json["user_id"],
        testId: json["test_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "test_id": testId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
