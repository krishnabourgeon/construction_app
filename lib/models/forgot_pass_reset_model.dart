// To parse this JSON data, do
//
//     final forgotPassResetModel = forgotPassResetModelFromJson(jsonString);

import 'dart:convert';

ForgotPassResetModel forgotPassResetModelFromJson(String str) => ForgotPassResetModel.fromJson(json.decode(str));

String forgotPassResetModelToJson(ForgotPassResetModel data) => json.encode(data.toJson());

class ForgotPassResetModel {
    bool status;
    String message;

    ForgotPassResetModel({
        required this.status,
        required this.message,
    });

    factory ForgotPassResetModel.fromJson(Map<String, dynamic> json) => ForgotPassResetModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
