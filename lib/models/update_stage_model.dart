// To parse this JSON data, do
//
//     final updateStageModel = updateStageModelFromJson(jsonString);

import 'dart:convert';

UpdateStageModel updateStageModelFromJson(String str) => UpdateStageModel.fromJson(json.decode(str));

String updateStageModelToJson(UpdateStageModel data) => json.encode(data.toJson());

class UpdateStageModel {
    bool status;
    String message;
    List<UpdateStage> data;

    UpdateStageModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UpdateStageModel.fromJson(Map<String, dynamic> json) => UpdateStageModel(
        status: json["status"],
        message: json["message"],
        data: List<UpdateStage>.from(json["data"].map((x) => UpdateStage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class UpdateStage {
    int id;
    int siteId;
    String stage;
    String description;
    int hasSubstage;
    int status;
    DateTime updatedAt;
    DateTime createdAt;

    UpdateStage({
        required this.id,
        required this.siteId,
        required this.stage,
        required this.description,
        required this.hasSubstage,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
    });

    factory UpdateStage.fromJson(Map<String, dynamic> json) => UpdateStage(
        id: json["id"],
        siteId: json["site_id"],
        stage: json["stage"],
        description: json["description"],
        hasSubstage: json["has_substage"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
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
    };
}
