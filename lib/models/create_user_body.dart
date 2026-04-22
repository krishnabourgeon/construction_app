// To parse this JSON data, do
//
//     final createUserBody = createUserBodyFromJson(jsonString);

import 'dart:convert';

CreateUserBody createUserBodyFromJson(String str) => CreateUserBody.fromJson(json.decode(str));

String createUserBodyToJson(CreateUserBody data) => json.encode(data.toJson());

class CreateUserBody {
    String name;
    String mobile;
    String email;
    String password;
    String passwordConfirmation;

    CreateUserBody({
        required this.name,
        required this.mobile,
        required this.email,
        required this.password,
        required this.passwordConfirmation,
    });

    factory CreateUserBody.fromJson(Map<String, dynamic> json) => CreateUserBody(
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
    };
}
