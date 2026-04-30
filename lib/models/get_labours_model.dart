// To parse this JSON data, do
//
//     final getLaboursModel = getLaboursModelFromJson(jsonString);

import 'dart:convert';

GetLaboursModel getLaboursModelFromJson(String str) => GetLaboursModel.fromJson(json.decode(str));

String getLaboursModelToJson(GetLaboursModel data) => json.encode(data.toJson());

class GetLaboursModel {
    bool status;
    String message;
    List<Labour> data;

    GetLaboursModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetLaboursModel.fromJson(Map<String, dynamic> json) => GetLaboursModel(
        status: json["status"],
        message: json["message"],
        data: List<Labour>.from(json["data"].map((x) => Labour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Labour {
    int id;
    int substageId;
    int noOfLabours;
    int? noOfDays;
    String amount;
    String? remarks;
    DateTime? addedDate;
    DateTime createdAt;
    DateTime updatedAt;

    Labour({
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

    factory Labour.fromJson(Map<String, dynamic> json) => Labour(
        id: json["id"] ?? 0,
        substageId: json["substage_id"] != null ? int.tryParse(json["substage_id"].toString()) ?? 0 : 0,
        noOfLabours: json["no_of_labours"] != null ? int.tryParse(json["no_of_labours"].toString()) ?? 0 : 0,
        noOfDays: json["no_of_days"] != null ? int.tryParse(json["no_of_days"].toString()) : null,
        amount: json["amount"]?.toString() ?? "0",
        remarks: json["remarks"],
        addedDate: json["added_date"] == null || json["added_date"] == "" ? null : DateTime.parse(json["added_date"]),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "substage_id": substageId,
        "no_of_labours": noOfLabours,
        "no_of_days": noOfDays,
        "amount": amount,
        "remarks": remarks,
        "added_date": "${addedDate!.year.toString().padLeft(4, '0')}-${addedDate!.month.toString().padLeft(2, '0')}-${addedDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
