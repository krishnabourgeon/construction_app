// To parse this JSON data, do
//
//     final sitesbycompanies = sitesbycompaniesFromJson(jsonString);

import 'dart:convert';

SitesbycompaniesModel sitesbycompaniesFromJson(String str) => SitesbycompaniesModel.fromJson(json.decode(str));

String sitesbycompaniesToJson(SitesbycompaniesModel data) => json.encode(data.toJson());

class SitesbycompaniesModel {
    bool status;
    List<SitesbyCompany> data;

    SitesbycompaniesModel({
        required this.status,
        required this.data,
    });

    factory SitesbycompaniesModel.fromJson(Map<String, dynamic> json) => SitesbycompaniesModel(
        status: json["status"],
        data: List<SitesbyCompany>.from(json["data"].map((x) => SitesbyCompany.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SitesbyCompany {
    int id;
    String sitename;

    SitesbyCompany({
        required this.id,
        required this.sitename,
    });

    factory SitesbyCompany.fromJson(Map<String, dynamic> json) => SitesbyCompany(
        id: json["id"],
        sitename: json["sitename"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sitename": sitename,
    };
}
