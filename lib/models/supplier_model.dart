// To parse this JSON data, do
//
//     final supplierModel = supplierModelFromJson(jsonString);

import 'dart:convert';

SupplierModel supplierModelFromJson(String str) => SupplierModel.fromJson(json.decode(str));

String supplierModelToJson(SupplierModel data) => json.encode(data.toJson());

class SupplierModel {
    bool status;
    String message;
    List<Supplier> data;

    SupplierModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
        status: json["status"],
        message: json["message"],
        data: List<Supplier>.from(json["data"].map((x) => Supplier.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Supplier {
    int id;
    String name;
    String contactNo;

    Supplier({
        required this.id,
        required this.name,
        required this.contactNo,
    });

    factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        name: json["name"],
        contactNo: json["contact_no"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact_no": contactNo,
    };
}
