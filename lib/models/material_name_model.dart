// To parse this JSON data, do
//
//     final materialsNameModel = materialsNameModelFromJson(jsonString);

import 'dart:convert';

MaterialsNameModel materialsNameModelFromJson(String str) => MaterialsNameModel.fromJson(json.decode(str));

String materialsNameModelToJson(MaterialsNameModel data) => json.encode(data.toJson());

class MaterialsNameModel {
    bool status;
    String message;
    List<Names> data;

    MaterialsNameModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory MaterialsNameModel.fromJson(Map<String, dynamic> json) => MaterialsNameModel(
        status: json["status"],
        message: json["message"],
        data: List<Names>.from(json["data"].map((x) => Names.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Names {
    int id;
    String name;

    Names({
        required this.id,
        required this.name,
    });

    factory Names.fromJson(Map<String, dynamic> json) => Names(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
