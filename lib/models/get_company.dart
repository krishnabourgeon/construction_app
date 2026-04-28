// To parse this JSON data, do
//
//     final getCompany = getCompanyFromJson(jsonString);

import 'dart:convert';

GetCompany getCompanyFromJson(String str) => GetCompany.fromJson(json.decode(str));

String getCompanyToJson(GetCompany data) => json.encode(data.toJson());

class GetCompany {
    bool status;
    List<Company> data;

    GetCompany({
        required this.status,
        required this.data,
    });

    factory GetCompany.fromJson(Map<String, dynamic> json) => GetCompany(
        status: json["status"],
        data: List<Company>.from(json["data"].map((x) => Company.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Company {
    int id;
    String name;

    Company({
        required this.id,
        required this.name,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
