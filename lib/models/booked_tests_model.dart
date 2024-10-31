// To parse this JSON data, do
//
//     final bookedTestModel = bookedTestModelFromJson(jsonString);

import 'dart:convert';

BookedTestModel bookedTestModelFromJson(String str) =>
    BookedTestModel.fromJson(json.decode(str));

String bookedTestModelToJson(BookedTestModel data) =>
    json.encode(data.toJson());

class BookedTestModel {
  int id;
  int userId;
  int testId;
  String testName;
  DateTime bookedTime;
  DateTime createdAt;
  DateTime updatedAt;

  BookedTestModel({
    required this.id,
    required this.userId,
    required this.testId,
    required this.testName,
    required this.bookedTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookedTestModel.fromJson(Map<String, dynamic> json) =>
      BookedTestModel(
        id: json["id"],
        userId: json["user_id"],
        testId: json["test_id"],
        testName: json["test_name"],
        bookedTime: DateTime.parse(json["booked_time"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "test_id": testId,
        "test_name": testName,
        "booked_time": bookedTime.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
