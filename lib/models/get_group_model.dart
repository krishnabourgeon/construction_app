// To parse this JSON data, do
//
//     final getGroupsModel = getGroupsModelFromJson(jsonString);

import 'dart:convert';

GetGroupsModel getGroupsModelFromJson(String str) => GetGroupsModel.fromJson(json.decode(str));

String getGroupsModelToJson(GetGroupsModel data) => json.encode(data.toJson());

class GetGroupsModel {
    bool status;
    String message;
    List<Groups> data;

    GetGroupsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetGroupsModel.fromJson(Map<String, dynamic> json) => GetGroupsModel(
        status: json["status"],
        message: json["message"],
        data: List<Groups>.from(json["data"].map((x) => Groups.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Groups {
    int id;
    String name;

    Groups({
        required this.id,
        required this.name,
    });

    factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
