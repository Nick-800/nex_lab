// To parse this JSON data, do
//
//     final testModel = testModelFromJson(jsonString);

import 'dart:convert';

TestModel testModelFromJson(String str) => TestModel.fromJson(json.decode(str));

String testModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  int id;
  String testName;
  String testDescription;
  String testType;
  int price;
  int duration;
  int availableSlots;
  String testCode;
  String instructions;
  int iconId;
  String preparationRequired;
  String status;
  int maxBookingsPerSlot;
  DateTime createdAt;
  DateTime updatedAt;

  TestModel({
    required this.id,
    required this.testName,
    required this.testDescription,
    required this.testType,
    required this.price,
    required this.duration,
    required this.availableSlots,
    required this.testCode,
    required this.instructions,
    required this.iconId,
    required this.preparationRequired,
    required this.status,
    required this.maxBookingsPerSlot,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json["id"],
        testName: json["test_name"],
        testDescription: json["test_description"],
        testType: json["test_type"],
        price: json["price"],
        duration: json["duration"],
        availableSlots: json["available_slots"],
        testCode: json["test_code"],
        instructions: json["instructions"],
        iconId: json["icon_id"],
        preparationRequired: json["preparation_required"],
        status: json["status"],
        maxBookingsPerSlot: json["max_bookings_per_slot"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "test_name": testName,
        "test_description": testDescription,
        "test_type": testType,
        "price": price,
        "duration": duration,
        "available_slots": availableSlots,
        "test_code": testCode,
        "instructions": instructions,
        "icon_id": iconId,
        "preparation_required": preparationRequired,
        "status": status,
        "max_bookings_per_slot": maxBookingsPerSlot,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
