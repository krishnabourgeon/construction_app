// To parse this JSON data, do
//
//     final updateStageBody = updateStageBodyFromJson(jsonString);

import 'dart:convert';

UpdateStageBody updateStageBodyFromJson(String str) => UpdateStageBody.fromJson(json.decode(str));

String updateStageBodyToJson(UpdateStageBody data) => json.encode(data.toJson());

class UpdateStageBody {
    int siteId;
    List<Stage> stages;

    UpdateStageBody({
        required this.siteId,
        required this.stages,
    });

    factory UpdateStageBody.fromJson(Map<String, dynamic> json) => UpdateStageBody(
        siteId: json["site_id"],
        stages: List<Stage>.from(json["stages"].map((x) => Stage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "stages": List<dynamic>.from(stages.map((x) => x.toJson())),
    };
}

class Stage {
    int id;
    String stage;
    String description;
    DateTime date;
    int status;
    int hasSubstage;

    Stage({
        required this.id,
        required this.stage,
        required this.description,
        required this.date,
        required this.status,
        required this.hasSubstage,
    });

    factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        stage: json["stage"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        hasSubstage: json["has_substage"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stage": stage,
        "description": description,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "has_substage": hasSubstage,
    };
}
