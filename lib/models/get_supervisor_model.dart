// To parse this JSON data, do
//
//     final getSupervisorsModel = getSupervisorsModelFromJson(jsonString);

import 'dart:convert';

GetSupervisorsModel getSupervisorsModelFromJson(String str) => GetSupervisorsModel.fromJson(json.decode(str));

String getSupervisorsModelToJson(GetSupervisorsModel data) => json.encode(data.toJson());

class GetSupervisorsModel {
    bool status;
    List<Supervisor> data;

    GetSupervisorsModel({
        required this.status,
        required this.data,
    });

    factory GetSupervisorsModel.fromJson(Map<String, dynamic> json) => GetSupervisorsModel(
        status: json["status"],
        data: List<Supervisor>.from(json["data"].map((x) => Supervisor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Supervisor {
    int id;
    String name;

    Supervisor({
        required this.id,
        required this.name,
    });

    factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
