// // To parse this JSON data, do
// //
// //     final loginModel = loginModelFromJson(jsonString);

// import 'dart:convert';

// LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

// String loginModelToJson(LoginModel data) => json.encode(data.toJson());

// class LoginModel {
//     bool status;
//     String message;
//     String? token;
//     Data? data;

//     LoginModel({
//         required this.status,
//         required this.message,
//         this.token,
//         this.data,
//     });

//     factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         status: json["status"] ?? false,
//         message: json["message"] ?? "",
//         token: json["token"],
//         data: json["data"] != null ? Data.fromJson(json["data"]) : null,
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "token": token,
//         "data": data?.toJson(),
//     };
// }

// class Data {
//     int id;
//     int companyId;
//     String? companyName;
//     String name;
//     String? email;
//     String? mobile;
//     String role;
//     String dashboard;

//     Data({
//         required this.id,
//         required this.companyId,
//         this.companyName,
//         required this.name,
//         this.email,
//         this.mobile,
//         required this.role,
//         required this.dashboard,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         companyId: json["company_id"],
//         companyName: json["company_name"],
//         name: json["name"] ?? "",
//         email: json["email"],
//         mobile: json["mobile"]?.toString(),
//         role: json["role"] ?? "",
//         dashboard: json["dashboard"] ?? "",
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "company_id": companyId,
//         "company_name": companyName,
//         "name": name,
//         "email": email,
//         "mobile": mobile,
//         "role": role,
//         "dashboard": dashboard,
//     };
// }





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
    String companyName;
    String name;
    dynamic email;
    String mobile;
    String role;
    DateTime date;
    DateTime trialStartsAt;
    DateTime trialExpiresAt;
    int trialDaysLeft;
    bool trialExpired;
    String dashboard;

    Data({
        required this.id,
        required this.companyId,
        required this.companyName,
        required this.name,
        required this.email,
        required this.mobile,
        required this.role,
        required this.date,
        required this.trialStartsAt,
        required this.trialExpiresAt,
        required this.trialDaysLeft,
        required this.trialExpired,
        required this.dashboard,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        date: DateTime.parse(json["date"]),
        trialStartsAt: DateTime.parse(json["trial_starts_at"]),
        trialExpiresAt: DateTime.parse(json["trial_expires_at"]),
        trialDaysLeft: json["trial_days_left"],
        trialExpired: json["trial_expired"],
        dashboard: json["dashboard"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "company_name": companyName,
        "name": name,
        "email": email,
        "mobile": mobile,
        "role": role,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "trial_starts_at": "${trialStartsAt.year.toString().padLeft(4, '0')}-${trialStartsAt.month.toString().padLeft(2, '0')}-${trialStartsAt.day.toString().padLeft(2, '0')}",
        "trial_expires_at": "${trialExpiresAt.year.toString().padLeft(4, '0')}-${trialExpiresAt.month.toString().padLeft(2, '0')}-${trialExpiresAt.day.toString().padLeft(2, '0')}",
        "trial_days_left": trialDaysLeft,
        "trial_expired": trialExpired,
        "dashboard": dashboard,
    };
}
