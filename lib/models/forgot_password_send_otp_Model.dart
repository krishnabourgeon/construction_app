// To parse this JSON data, do
//
//     final forgotPasswordSendOtpModel = forgotPasswordSendOtpModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordSendOtpModel forgotPasswordSendOtpModelFromJson(String str) => ForgotPasswordSendOtpModel.fromJson(json.decode(str));

String forgotPasswordSendOtpModelToJson(ForgotPasswordSendOtpModel data) => json.encode(data.toJson());

class ForgotPasswordSendOtpModel {
    bool status;
    String message;

    ForgotPasswordSendOtpModel({
        required this.status,
        required this.message,
    });

    factory ForgotPasswordSendOtpModel.fromJson(Map<String, dynamic> json) => ForgotPasswordSendOtpModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
