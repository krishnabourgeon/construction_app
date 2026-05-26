// To parse this JSON data, do
//
//     final addledgerModel = addledgerModelFromJson(jsonString);

import 'dart:convert';

AddledgerModel addledgerModelFromJson(String str) => AddledgerModel.fromJson(json.decode(str));

String addledgerModelToJson(AddledgerModel data) => json.encode(data.toJson());

class AddledgerModel {
    bool status;
    String message;
    Data data;

    AddledgerModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddledgerModel.fromJson(Map<String, dynamic> json) => AddledgerModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String name;
    int groupId;
    String groupName;
    String initials;

    Data({
        required this.id,
        required this.name,
        required this.groupId,
        required this.groupName,
        required this.initials,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        groupId: json["group_id"],
        groupName: json["group_name"],
        initials: json["initials"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "group_id": groupId,
        "group_name": groupName,
        "initials": initials,
    };
}
