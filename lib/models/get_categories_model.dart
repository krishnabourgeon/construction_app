// To parse this JSON data, do
//
//     final getCategoriesModel = getCategoriesModelFromJson(jsonString);

import 'dart:convert';

GetCategoriesModel getCategoriesModelFromJson(String str) => GetCategoriesModel.fromJson(json.decode(str));

String getCategoriesModelToJson(GetCategoriesModel data) => json.encode(data.toJson());

class GetCategoriesModel {
    bool status;
    String message;
    List<Catergories> data;

    GetCategoriesModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetCategoriesModel.fromJson(Map<String, dynamic> json) => GetCategoriesModel(
        status: json["status"],
        message: json["message"],
        data: List<Catergories>.from(json["data"].map((x) => Catergories.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Catergories {
    int id;
    String name;

    Catergories({
        required this.id,
        required this.name,
    });

    factory Catergories.fromJson(Map<String, dynamic> json) => Catergories(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
