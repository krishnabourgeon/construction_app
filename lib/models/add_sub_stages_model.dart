// To parse this JSON data, do
//
//     final addSubStagesModel = addSubStagesModelFromJson(jsonString);

import 'dart:convert';

AddSubStagesModel addSubStagesModelFromJson(String str) => AddSubStagesModel.fromJson(json.decode(str));

String addSubStagesModelToJson(AddSubStagesModel data) => json.encode(data.toJson());

class AddSubStagesModel {
    bool status;
    String message;
    List<AddSubStage> data;

    AddSubStagesModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddSubStagesModel.fromJson(Map<String, dynamic> json) => AddSubStagesModel(
        status: json["status"],
        message: json["message"],
        data: List<AddSubStage>.from(json["data"].map((x) => AddSubStage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AddSubStage {
    int siteId;
    int stageId;
    String substage;
    dynamic description;
    int status;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    AddSubStage({
        required this.siteId,
        required this.stageId,
        required this.substage,
        required this.description,
        required this.status,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory AddSubStage.fromJson(Map<String, dynamic> json) => AddSubStage(
        siteId: json["site_id"],
        stageId: json["stage_id"],
        substage: json["substage"],
        description: json["description"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "stage_id": stageId,
        "substage": substage,
        "description": description,
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
