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
    String? token;
    Data? data;

    LoginModel({
        required this.status,
        required this.message,
        this.token,
        this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        token: json["token"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "data": data?.toJson(),
    };
}

class Data {
    int id;
    int companyId;
    String? companyName;
    String name;
    dynamic email;
    String? mobile;
    String role;
    DateTime? date;
    DateTime? trialStartsAt;
    DateTime? trialExpiresAt;
    int? trialDaysLeft;
    bool? trialExpired;
    String dashboard;

    Data({
        required this.id,
        required this.companyId,
        this.companyName,
        required this.name,
        required this.email,
        this.mobile,
        required this.role,
        this.date,
        this.trialStartsAt,
        this.trialExpiresAt,
        this.trialDaysLeft,
        this.trialExpired,
        required this.dashboard,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        companyId: json["company_id"] ?? 0,
        companyName: json["company_name"],
        name: json["name"] ?? "",
        email: json["email"],
        mobile: json["mobile"]?.toString(),
        role: json["role"] ?? "",
        date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
        trialStartsAt: json["trial_starts_at"] != null ? DateTime.tryParse(json["trial_starts_at"]) : null,
        trialExpiresAt: json["trial_expires_at"] != null ? DateTime.tryParse(json["trial_expires_at"]) : null,
        trialDaysLeft: json["trial_days_left"],
        trialExpired: json["trial_expired"],
        dashboard: json["dashboard"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "company_name": companyName,
        "name": name,
        "email": email,
        "mobile": mobile,
        "role": role,
        "date": date?.toIso8601String(),
        "trial_starts_at": trialStartsAt?.toIso8601String(),
        "trial_expires_at": trialExpiresAt?.toIso8601String(),
        "trial_days_left": trialDaysLeft,
        "trial_expired": trialExpired,
        "dashboard": dashboard,
    };
}
