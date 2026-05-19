// To parse this JSON data, do
//
//     final changePasswordBody = changePasswordBodyFromJson(jsonString);

import 'dart:convert';

ChangePasswordBody changePasswordBodyFromJson(String str) => ChangePasswordBody.fromJson(json.decode(str));

String changePasswordBodyToJson(ChangePasswordBody data) => json.encode(data.toJson());

class ChangePasswordBody {
    String newPassword;
    String newPasswordConfirmation;

    ChangePasswordBody({
        required this.newPassword,
        required this.newPasswordConfirmation,
    });

    factory ChangePasswordBody.fromJson(Map<String, dynamic> json) => ChangePasswordBody(
        newPassword: json["new_password"],
        newPasswordConfirmation: json["new_password_confirmation"],
    );

    Map<String, dynamic> toJson() => {
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
    };
}
