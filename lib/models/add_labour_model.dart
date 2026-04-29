// To parse this JSON data, do
//
//     final addLabourModel = addLabourModelFromJson(jsonString);

import 'dart:convert';

AddLabourModel addLabourModelFromJson(String str) => AddLabourModel.fromJson(json.decode(str));

String addLabourModelToJson(AddLabourModel data) => json.encode(data.toJson());

class AddLabourModel {
    bool status;
    String message;
    Data data;

    AddLabourModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddLabourModel.fromJson(Map<String, dynamic> json) => AddLabourModel(
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
    int substageId;
    int noOfLabours;
    int noOfDays;
    int amount;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Data({
        required this.substageId,
        required this.noOfLabours,
        required this.noOfDays,
        required this.amount,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        substageId: json["substage_id"],
        noOfLabours: json["no_of_labours"],
        noOfDays: json["no_of_days"],
        amount: json["amount"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "substage_id": substageId,
        "no_of_labours": noOfLabours,
        "no_of_days": noOfDays,
        "amount": amount,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
