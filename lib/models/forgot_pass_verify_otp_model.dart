// To parse this JSON data, do
//
//     final forgotPassVerifyOtpModel = forgotPassVerifyOtpModelFromJson(jsonString);

import 'dart:convert';

ForgotPassVerifyOtpModel forgotPassVerifyOtpModelFromJson(String str) => ForgotPassVerifyOtpModel.fromJson(json.decode(str));

String forgotPassVerifyOtpModelToJson(ForgotPassVerifyOtpModel data) => json.encode(data.toJson());

class ForgotPassVerifyOtpModel {
    bool status;
    String message;
    String? resetToken;

    ForgotPassVerifyOtpModel({
        required this.status,
        required this.message,
        this.resetToken,
    });

    factory ForgotPassVerifyOtpModel.fromJson(Map<String, dynamic> json) => ForgotPassVerifyOtpModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        resetToken: json["reset_token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "reset_token": resetToken,
    };
}
