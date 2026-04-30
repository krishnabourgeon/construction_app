// To parse this JSON data, do
//
//     final sitesbycompaniesModel = sitesbycompaniesModelFromJson(jsonString);

import 'dart:convert';

SitesbycompaniesModel sitesbycompaniesModelFromJson(String str) => SitesbycompaniesModel.fromJson(json.decode(str));

String sitesbycompaniesModelToJson(SitesbycompaniesModel data) => json.encode(data.toJson());

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
    String contactperson;
    String mobile;
    String estimateAmount;
    int supervisorId;
    DateTime startDate;
    DateTime tentativeCompletionDate;

    SitesbyCompany({
        required this.id,
        required this.sitename,
        required this.contactperson,
        required this.mobile,
        required this.estimateAmount,
        required this.supervisorId,
        required this.startDate,
        required this.tentativeCompletionDate,
    });

    factory SitesbyCompany.fromJson(Map<String, dynamic> json) => SitesbyCompany(
        id: json["id"],
        sitename: json["sitename"],
        contactperson: json["contactperson"],
        mobile: json["mobile"],
        estimateAmount: json["estimate_amount"],
        supervisorId: json["supervisor_id"],
        startDate: DateTime.parse(json["start_date"]),
        tentativeCompletionDate: DateTime.parse(json["tentative_completion_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sitename": sitename,
        "contactperson": contactperson,
        "mobile": mobile,
        "estimate_amount": estimateAmount,
        "supervisor_id": supervisorId,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "tentative_completion_date": "${tentativeCompletionDate.year.toString().padLeft(4, '0')}-${tentativeCompletionDate.month.toString().padLeft(2, '0')}-${tentativeCompletionDate.day.toString().padLeft(2, '0')}",
    };
}
