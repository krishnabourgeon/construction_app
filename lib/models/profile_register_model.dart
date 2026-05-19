// To parse this JSON data, do
//
//     final profileRegisterModel = profileRegisterModelFromJson(jsonString);

import 'dart:convert';

ProfileRegisterModel profileRegisterModelFromJson(String str) => ProfileRegisterModel.fromJson(json.decode(str));

String profileRegisterModelToJson(ProfileRegisterModel data) => json.encode(data.toJson());

class ProfileRegisterModel {
    bool status;
    String message;
    Data data;

    ProfileRegisterModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory ProfileRegisterModel.fromJson(Map<String, dynamic> json) => ProfileRegisterModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int companyId;
    String companyName;

    Data({
        required this.companyId,
        required this.companyName,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        companyId: json["company_id"],
        companyName: json["company_name"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "company_name": companyName,
    };
}
