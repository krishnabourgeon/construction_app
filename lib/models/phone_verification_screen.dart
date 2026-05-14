// To parse this JSON data, do
//
//     final phoneNumberVerficationModel = phoneNumberVerficationModelFromJson(jsonString);

import 'dart:convert';

PhoneNumberVerficationModel phoneNumberVerficationModelFromJson(String str) => PhoneNumberVerficationModel.fromJson(json.decode(str));

String phoneNumberVerficationModelToJson(PhoneNumberVerficationModel data) => json.encode(data.toJson());

class PhoneNumberVerficationModel {
    bool status;
    String message;

    PhoneNumberVerficationModel({
        required this.status,
        required this.message,
    });

    factory PhoneNumberVerficationModel.fromJson(Map<String, dynamic> json) => PhoneNumberVerficationModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
