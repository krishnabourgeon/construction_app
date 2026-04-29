// To parse this JSON data, do
//
//     final getStagesModel = getStagesModelFromJson(jsonString);

import 'dart:convert';

GetStagesModel getStagesModelFromJson(String str) => GetStagesModel.fromJson(json.decode(str));

String getStagesModelToJson(GetStagesModel data) => json.encode(data.toJson());

class GetStagesModel {
    bool status;
    List<GetStages> data;

    GetStagesModel({
        required this.status,
        required this.data,
    });

    factory GetStagesModel.fromJson(Map<String, dynamic> json) => GetStagesModel(
        status: json["status"],
        data: List<GetStages>.from(json["data"].map((x) => GetStages.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetStages {
    int id;
    int siteId;
    String stage;
    String description;
    int hasSubstage;
    int status;
    DateTime updatedAt;
    DateTime createdAt;
    String statusLabel;

    GetStages({
        required this.id,
        required this.siteId,
        required this.stage,
        required this.description,
        required this.hasSubstage,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.statusLabel,
    });

    factory GetStages.fromJson(Map<String, dynamic> json) => GetStages(
        id: json["id"] ?? 0,
        siteId: json["site_id"] ?? 0,
        stage: json["stage"] ?? "",
        description: json["description"] ?? "",
        hasSubstage: json["has_substage"] ?? 0,
        status: json["status"] ?? 0,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
        statusLabel: json["status_label"] ?? "",
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
    };
}
