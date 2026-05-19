// To parse this JSON data, do
//
//     final editProfileBody = editProfileBodyFromJson(jsonString);

import 'dart:convert';

EditProfileBody editProfileBodyFromJson(String str) => EditProfileBody.fromJson(json.decode(str));

String editProfileBodyToJson(EditProfileBody data) => json.encode(data.toJson());

class EditProfileBody {
    String name;
    Company company;

    EditProfileBody({
        required this.name,
        required this.company,
    });

    factory EditProfileBody.fromJson(Map<String, dynamic> json) => EditProfileBody(
        name: json["name"],
        company: Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "company": company.toJson(),
    };
}

class Company {
    String name;
    String email;
    String phone;
    String companyType;
    String registrationNumber;
    String gstNumber;
    String address;
    String city;
    String state;
    String pincode;

    Company({
        required this.name,
        required this.email,
        required this.phone,
        required this.companyType,
        required this.registrationNumber,
        required this.gstNumber,
        required this.address,
        required this.city,
        required this.state,
        required this.pincode,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        companyType: json["company_type"],
        registrationNumber: json["registration_number"],
        gstNumber: json["gst_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "company_type": companyType,
        "registration_number": registrationNumber,
        "gst_number": gstNumber,
        "address": address,
        "city": city,
        "state": state,
        "pincode": pincode,
    };
}
