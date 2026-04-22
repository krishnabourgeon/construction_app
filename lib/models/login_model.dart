// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool status;
    String message;
    String token;
    Data data;

    LoginModel({
        required this.status,
        required this.message,
        required this.token,
        required this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    int companyId;
    String name;
    String email;
    String role;
    String dashboard;

    Data({
        required this.id,
        required this.companyId,
        required this.name,
        required this.email,
        required this.role,
        required this.dashboard,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        dashboard: json["dashboard"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "email": email,
        "role": role,
        "dashboard": dashboard,
    };
}
