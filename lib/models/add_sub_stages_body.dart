// To parse this JSON data, do
//
//     final addSubStagesBody = addSubStagesBodyFromJson(jsonString);

import 'dart:convert';

AddSubStagesBody addSubStagesBodyFromJson(String str) => AddSubStagesBody.fromJson(json.decode(str));

String addSubStagesBodyToJson(AddSubStagesBody data) => json.encode(data.toJson());

class AddSubStagesBody {
    int siteId;
    int stageId;
    List<Substage> substages;

    AddSubStagesBody({
        required this.siteId,
        required this.stageId,
        required this.substages,
    });

    factory AddSubStagesBody.fromJson(Map<String, dynamic> json) => AddSubStagesBody(
        siteId: json["site_id"],
        stageId: json["stage_id"],
        substages: List<Substage>.from(json["substages"].map((x) => Substage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "stage_id": stageId,
        "substages": List<dynamic>.from(substages.map((x) => x.toJson())),
    };
}

class Substage {
    String substage;
    int status;
    String? description;

    Substage({
        required this.substage,
        required this.status,
        this.description,
    });

    factory Substage.fromJson(Map<String, dynamic> json) => Substage(
        substage: json["substage"],
        status: json["status"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "substage": substage,
        "status": status,
        "description": description,
    };
}
