// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String name;
  String email;
  String phone;
  String location;
  String dob;
  String gender;
  String bookedTests;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.dob,
    required this.gender,
    required this.bookedTests,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        location: json["location"] ?? '',
        dob: json["DOB"],
        gender: json["gender"],
        bookedTests: json["booked_tests"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "location": location,
        "DOB": dob,
        // "${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}-${dob.year.toString().padLeft(4, '0')}-",
        "gender": gender,
        "booked_tests": bookedTests,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
