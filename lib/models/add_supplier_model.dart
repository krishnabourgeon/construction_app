// To parse this JSON data, do
//
//     final addSupplierModel = addSupplierModelFromJson(jsonString);

import 'dart:convert';

AddSupplierModel addSupplierModelFromJson(String str) => AddSupplierModel.fromJson(json.decode(str));

String addSupplierModelToJson(AddSupplierModel data) => json.encode(data.toJson());

class AddSupplierModel {
    bool status;
    String message;
    Data data;

    AddSupplierModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddSupplierModel.fromJson(Map<String, dynamic> json) => AddSupplierModel(
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
    String name;
    String contactNo;
    String address;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Data({
        required this.name,
        required this.contactNo,
        required this.address,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        contactNo: json["contact_no"],
        address: json["address"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "contact_no": contactNo,
        "address": address,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
