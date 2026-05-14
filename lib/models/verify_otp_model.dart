// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
    bool status;
    String message;
    int companyId;
    String companyName;
    String regToken;

    VerifyOtpModel({
        required this.status,
        required this.message,
        required this.companyId,
        required this.companyName,
        required this.regToken,
    });

    factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        status: json["status"],
        message: json["message"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        regToken: json["reg_token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "company_id": companyId,
        "company_name": companyName,
        "reg_token": regToken,
    };
}
