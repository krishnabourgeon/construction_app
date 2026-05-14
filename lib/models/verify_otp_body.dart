// To parse this JSON data, do
//
//     final verifyOtpBody = verifyOtpBodyFromJson(jsonString);

import 'dart:convert';

VerifyOtpBody verifyOtpBodyFromJson(String str) => VerifyOtpBody.fromJson(json.decode(str));

String verifyOtpBodyToJson(VerifyOtpBody data) => json.encode(data.toJson());

class VerifyOtpBody {
    int otp;
    int phoneNumber;

    VerifyOtpBody({
        required this.otp,
        required this.phoneNumber,
    });

    factory VerifyOtpBody.fromJson(Map<String, dynamic> json) => VerifyOtpBody(
        otp: json["otp"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "otp": otp,
        "phone_number": phoneNumber,
    };
}
