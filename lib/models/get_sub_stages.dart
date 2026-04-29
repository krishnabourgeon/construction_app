// To parse this JSON data, do
//
//     final getSubStages = getSubStagesFromJson(jsonString);

import 'dart:convert';

GetSubStages getSubStagesFromJson(String str) => GetSubStages.fromJson(json.decode(str));

String getSubStagesToJson(GetSubStages data) => json.encode(data.toJson());

class GetSubStages {
    bool status;
    List<SubStages> data;

    GetSubStages({
        required this.status,
        required this.data,
    });

    factory GetSubStages.fromJson(Map<String, dynamic> json) => GetSubStages(
        status: json["status"],
        data: List<SubStages>.from(json["data"].map((x) => SubStages.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SubStages {
    int id;
    int siteId;
    String stage;
    String description;
    int hasSubstage;
    int status;
    DateTime updatedAt;
    DateTime createdAt;
    String statusLabel;
    List<SubStage> subStages;

    SubStages({
        required this.id,
        required this.siteId,
        required this.stage,
        required this.description,
        required this.hasSubstage,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.statusLabel,
        required this.subStages,
    });

    factory SubStages.fromJson(Map<String, dynamic> json) => SubStages(
        id: json["id"] ?? 0,
        siteId: json["site_id"] ?? 0,
        stage: json["stage"] ?? "",
        description: json["description"] ?? "",
        hasSubstage: json["has_substage"] ?? 0,
        status: json["status"] ?? 0,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
        statusLabel: json["status_label"] ?? "",
        subStages: json["sub_stages"] != null 
            ? List<SubStage>.from(json["sub_stages"].map((x) => SubStage.fromJson(x)))
            : [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "site_id": siteId,
        "stage": stage,
        "description": description,
        "has_substage": hasSubstage,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "status_label": statusLabel,
        "sub_stages": List<dynamic>.from(subStages.map((x) => x.toJson())),
    };
}

class SubStage {
    int id;
    int siteId;
    int stageId;
    String substage;
    String description;
    int status;
    DateTime updatedAt;
    DateTime createdAt;
    String statusLabel;

    SubStage({
        required this.id,
        required this.siteId,
        required this.stageId,
        required this.substage,
        required this.description,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.statusLabel,
    });

    factory SubStage.fromJson(Map<String, dynamic> json) => SubStage(
        id: json["id"] ?? 0,
        siteId: json["site_id"] ?? 0,
        stageId: json["stage_id"] ?? 0,
        substage: json["substage"] ?? "",
        description: json["description"] ?? "",
        status: json["status"] ?? 0,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
        statusLabel: json["status_label"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "site_id": siteId,
        "stage_id": stageId,
        "substage": substage,
        "description": description,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "status_label": statusLabel,
    };
}
