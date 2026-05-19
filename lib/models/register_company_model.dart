// To parse this JSON data, do
//
//     final registerCompanyModel = registerCompanyModelFromJson(jsonString);

import 'dart:convert';

RegisterCompanyModel registerCompanyModelFromJson(String str) => RegisterCompanyModel.fromJson(json.decode(str));

String registerCompanyModelToJson(RegisterCompanyModel data) => json.encode(data.toJson());

class RegisterCompanyModel {
    bool status;
    String? message;
    Data? data;

    RegisterCompanyModel({
        required this.status,
        this.message,
        this.data,
    });

    factory RegisterCompanyModel.fromJson(Map<String, dynamic> json) => RegisterCompanyModel(
        status: json["status"] ?? false,
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    int? companyId;
    String? companyName;
    String? adminEmail;

    Data({
        this.companyId,
        this.companyName,
        this.adminEmail,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        companyId: json["company_id"],
        companyName: json["company_name"],
        adminEmail: json["admin_email"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "company_name": companyName,
        "admin_email": adminEmail,
    };
}
