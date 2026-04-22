// To parse this JSON data, do
//
//     final createUserModel = createUserModelFromJson(jsonString);

import 'dart:convert';

CreateUserModel createUserModelFromJson(String str) => CreateUserModel.fromJson(json.decode(str));

String createUserModelToJson(CreateUserModel data) => json.encode(data.toJson());

class CreateUserModel {
    bool status;
    String message;
    CreateUser data;

    CreateUserModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CreateUserModel.fromJson(Map<String, dynamic> json) => CreateUserModel(
        status: json["status"],
        message: json["message"],
        data: CreateUser.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class CreateUser {
    String name;
    String mobile;
    String email;
    int companyId;
    int roleId;
    int status;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    CreateUser({
        required this.name,
        required this.mobile,
        required this.email,
        required this.companyId,
        required this.roleId,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        companyId: json["company_id"],
        roleId: json["role_id"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "email": email,
        "company_id": companyId,
        "role_id": roleId,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
