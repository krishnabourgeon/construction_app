// To parse this JSON data, do
//
//     final phoneNumberVerficationBody = phoneNumberVerficationBodyFromJson(jsonString);

import 'dart:convert';

PhoneNumberVerficationBody phoneNumberVerficationBodyFromJson(String str) => PhoneNumberVerficationBody.fromJson(json.decode(str));

String phoneNumberVerficationBodyToJson(PhoneNumberVerficationBody data) => json.encode(data.toJson());

class PhoneNumberVerficationBody {
    String contactPerson;
    String companyName;
    int phoneNumber;

    PhoneNumberVerficationBody({
        required this.contactPerson,
        required this.companyName,
        required this.phoneNumber,
    });

    factory PhoneNumberVerficationBody.fromJson(Map<String, dynamic> json) => PhoneNumberVerficationBody(
        contactPerson: json["contact_person"],
        companyName: json["company_name"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "contact_person": contactPerson,
        "company_name": companyName,
        "phone_number": phoneNumber,
    };
}
