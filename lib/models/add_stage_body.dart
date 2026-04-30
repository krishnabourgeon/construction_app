// To parse this JSON data, do
//
//     final addStagesBody = addStagesBodyFromJson(jsonString);

import 'dart:convert';

AddStagesBody addStagesBodyFromJson(String str) => AddStagesBody.fromJson(json.decode(str));

String addStagesBodyToJson(AddStagesBody data) => json.encode(data.toJson());

class AddStagesBody {
    int siteId;
    List<Stages> stages;

    AddStagesBody({
        required this.siteId,
        required this.stages,
    });

    factory AddStagesBody.fromJson(Map<String, dynamic> json) => AddStagesBody(
        siteId: json["site_id"],
        stages: List<Stages>.from(json["stages"].map((x) => Stages.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "stages": List<dynamic>.from(stages.map((x) => x.toJson())),
    };
}

class Stages {
    String stage;
    int hasSubstage;
    String? description;
    int? status;

    Stages({
        required this.stage,
        required this.hasSubstage,
        this.description,
        this.status,
    });

    factory Stages.fromJson(Map<String, dynamic> json) => Stages(
        stage: json["stage"],
        hasSubstage: json["has_substage"],
        description: json["description"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "stage": stage,
        "has_substage": hasSubstage,
        "description": description,
        "status": status,
    };
}
