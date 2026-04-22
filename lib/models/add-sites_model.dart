// To parse this JSON data, do
//
//     final addSitesModel = addSitesModelFromJson(jsonString);

import 'dart:convert';

AddSitesModel addSitesModelFromJson(String str) => AddSitesModel.fromJson(json.decode(str));

String addSitesModelToJson(AddSitesModel data) => json.encode(data.toJson());

class AddSitesModel {
    bool status;
    String message;
    Data data;

    AddSitesModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddSitesModel.fromJson(Map<String, dynamic> json) => AddSitesModel(
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
    int companyId;
    String sitename;
    String contactperson;
    String mobile;
    int supervisorId;
    DateTime startDate;
    DateTime tentativeCompletionDate;
    int estimateAmount;
    String description;
    int status;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Data({
        required this.companyId,
        required this.sitename,
        required this.contactperson,
        required this.mobile,
        required this.supervisorId,
        required this.startDate,
        required this.tentativeCompletionDate,
        required this.estimateAmount,
        required this.description,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        companyId: json["company_id"],
        sitename: json["sitename"],
        contactperson: json["contactperson"],
        mobile: json["mobile"],
        supervisorId: json["supervisor_id"],
        startDate: DateTime.parse(json["start_date"]),
        tentativeCompletionDate: DateTime.parse(json["tentative_completion_date"]),
        estimateAmount: json["estimate_amount"],
        description: json["description"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "sitename": sitename,
        "contactperson": contactperson,
        "mobile": mobile,
        "supervisor_id": supervisorId,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "tentative_completion_date": "${tentativeCompletionDate.year.toString().padLeft(4, '0')}-${tentativeCompletionDate.month.toString().padLeft(2, '0')}-${tentativeCompletionDate.day.toString().padLeft(2, '0')}",
        "estimate_amount": estimateAmount,
        "description": description,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
