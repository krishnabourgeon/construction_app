// To parse this JSON data, do
//
//     final setPasswordBody = setPasswordBodyFromJson(jsonString);

import 'dart:convert';

SetPasswordBody setPasswordBodyFromJson(String str) => SetPasswordBody.fromJson(json.decode(str));

String setPasswordBodyToJson(SetPasswordBody data) => json.encode(data.toJson());

class SetPasswordBody {
    int companyId;
    String password;
    String passwordConfirmation;

    SetPasswordBody({
        required this.companyId,
        required this.password,
        required this.passwordConfirmation,
    });

    factory SetPasswordBody.fromJson(Map<String, dynamic> json) => SetPasswordBody(
        companyId: json["company_id"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "password": password,
        "password_confirmation": passwordConfirmation,
    };
}
