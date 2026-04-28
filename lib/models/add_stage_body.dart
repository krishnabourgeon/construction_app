// To parse this JSON data, do
//
//     final addStagesBody = addStagesBodyFromJson(jsonString);

import 'dart:convert';

AddStagesBody addStagesBodyFromJson(String str) => AddStagesBody.fromJson(json.decode(str));

String addStagesBodyToJson(AddStagesBody data) => json.encode(data.toJson());

class AddStagesBody {
    int siteId;
    List<Stage> stages;

    AddStagesBody({
        required this.siteId,
        required this.stages,
    });

    factory AddStagesBody.fromJson(Map<String, dynamic> json) => AddStagesBody(
        siteId: json["site_id"],
        stages: List<Stage>.from(json["stages"].map((x) => Stage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "stages": List<dynamic>.from(stages.map((x) => x.toJson())),
    };
}

class Stage {
    String stage;
    int hasSubstage;

    Stage({
        required this.stage,
        required this.hasSubstage,
    });

    factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        stage: json["stage"],
        hasSubstage: json["has_substage"],
    );

    Map<String, dynamic> toJson() => {
        "stage": stage,
        "has_substage": hasSubstage,
    };
}
