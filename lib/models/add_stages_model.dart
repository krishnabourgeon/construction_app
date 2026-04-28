// To parse this JSON data, do
//
//     final addStagesModel = addStagesModelFromJson(jsonString);

import 'dart:convert';

AddStagesModel addStagesModelFromJson(String str) => AddStagesModel.fromJson(json.decode(str));

String addStagesModelToJson(AddStagesModel data) => json.encode(data.toJson());

class AddStagesModel {
    bool status;
    String message;
    List<AddStage> data;

    AddStagesModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddStagesModel.fromJson(Map<String, dynamic> json) => AddStagesModel(
        status: json["status"],
        message: json["message"],
        data: List<AddStage>.from(json["data"].map((x) => AddStage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AddStage {
    int siteId;
    String stage;
    dynamic description;
    int status;
    int hasSubstage;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    AddStage({
        required this.siteId,
        required this.stage,
        required this.description,
        required this.status,
        required this.hasSubstage,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AddStage.fromJson(Map<String, dynamic> json) => AddStage(
        siteId: json["site_id"],
        stage: json["stage"],
        description: json["description"],
        status: json["status"],
        hasSubstage: json["has_substage"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "stage": stage,
        "description": description,
        "status": status,
        "has_substage": hasSubstage,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
