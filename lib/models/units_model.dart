// To parse this JSON data, do
//
//     final unitsModel = unitsModelFromJson(jsonString);

import 'dart:convert';

UnitsModel unitsModelFromJson(String str) => UnitsModel.fromJson(json.decode(str));

String unitsModelToJson(UnitsModel data) => json.encode(data.toJson());

class UnitsModel {
    bool status;
    String message;
    List<Units> data;

    UnitsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UnitsModel.fromJson(Map<String, dynamic> json) => UnitsModel(
        status: json["status"],
        message: json["message"],
        data: List<Units>.from(json["data"].map((x) => Units.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Units {
    int id;
    String name;
    String shortName;

    Units({
        required this.id,
        required this.name,
        required this.shortName,
    });

    factory Units.fromJson(Map<String, dynamic> json) => Units(
        id: json["id"],
        name: json["name"],
        shortName: json["short_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_name": shortName,
    };
}
