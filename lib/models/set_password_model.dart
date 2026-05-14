// To parse this JSON data, do
//
//     final setPasswordModel = setPasswordModelFromJson(jsonString);

import 'dart:convert';

SetPasswordModel setPasswordModelFromJson(String str) => SetPasswordModel.fromJson(json.decode(str));

String setPasswordModelToJson(SetPasswordModel data) => json.encode(data.toJson());

class SetPasswordModel {
    bool status;
    String message;
    SetPasswordData data;

    SetPasswordModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SetPasswordModel.fromJson(Map<String, dynamic> json) => SetPasswordModel(
        status: json["status"],
        message: json["message"],
        data: SetPasswordData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class SetPasswordData {
    int companyId;
    String mobile;

    SetPasswordData({
        required this.companyId,
        required this.mobile,
    });

    factory SetPasswordData.fromJson(Map<String, dynamic> json) => SetPasswordData(
        companyId: json["company_id"],
        mobile: json["mobile"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "mobile": mobile,
    };
}
