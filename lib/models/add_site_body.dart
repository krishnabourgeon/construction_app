// To parse this JSON data, do
//
//     final addSitesBody = addSitesBodyFromJson(jsonString);

import 'dart:convert';

AddSitesBody addSitesBodyFromJson(String str) => AddSitesBody.fromJson(json.decode(str));

String addSitesBodyToJson(AddSitesBody data) => json.encode(data.toJson());

class AddSitesBody {
    String sitename;
    String contactperson;
    String mobile;
    int supervisorId;
    DateTime startDate;
    DateTime tentativeCompletionDate;
    int estimateAmount;
    String description;

    AddSitesBody({
        required this.sitename,
        required this.contactperson,
        required this.mobile,
        required this.supervisorId,
        required this.startDate,
        required this.tentativeCompletionDate,
        required this.estimateAmount,
        required this.description,
    });

    factory AddSitesBody.fromJson(Map<String, dynamic> json) => AddSitesBody(
        sitename: json["sitename"],
        contactperson: json["contactperson"],
        mobile: json["mobile"],
        supervisorId: json["supervisor_id"],
        startDate: DateTime.parse(json["start_date"]),
        tentativeCompletionDate: DateTime.parse(json["tentative_completion_date"]),
        estimateAmount: json["estimate_amount"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "sitename": sitename,
        "contactperson": contactperson,
        "mobile": mobile,
        "supervisor_id": supervisorId,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "tentative_completion_date": "${tentativeCompletionDate.year.toString().padLeft(4, '0')}-${tentativeCompletionDate.month.toString().padLeft(2, '0')}-${tentativeCompletionDate.day.toString().padLeft(2, '0')}",
        "estimate_amount": estimateAmount,
        "description": description,
    };
}
