// To parse this JSON data, do
//
//     final labourEditModel = labourEditModelFromJson(jsonString);

import 'dart:convert';

LabourEditModel labourEditModelFromJson(String str) => LabourEditModel.fromJson(json.decode(str));

String labourEditModelToJson(LabourEditModel data) => json.encode(data.toJson());

class LabourEditModel {
    bool status;
    String message;
    Data data;

    LabourEditModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory LabourEditModel.fromJson(Map<String, dynamic> json) => LabourEditModel(
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
    int id;
    int substageId;
    int noOfLabours;
    int noOfDays;
    int amount;
    dynamic remarks;
    dynamic addedDate;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.substageId,
        required this.noOfLabours,
        required this.noOfDays,
        required this.amount,
        required this.remarks,
        required this.addedDate,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        substageId: json["substage_id"],
        noOfLabours: json["no_of_labours"],
        noOfDays: json["no_of_days"],
        amount: json["amount"],
        remarks: json["remarks"],
        addedDate: json["added_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "substage_id": substageId,
        "no_of_labours": noOfLabours,
        "no_of_days": noOfDays,
        "amount": amount,
        "remarks": remarks,
        "added_date": addedDate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
