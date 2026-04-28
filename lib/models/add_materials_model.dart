// To parse this JSON data, do
//
//     final addMaterialsModel = addMaterialsModelFromJson(jsonString);

import 'dart:convert';

AddMaterialsModel addMaterialsModelFromJson(String str) => AddMaterialsModel.fromJson(json.decode(str));

String addMaterialsModelToJson(AddMaterialsModel data) => json.encode(data.toJson());

class AddMaterialsModel {
    bool status;
    String message;
    Data data;

    AddMaterialsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddMaterialsModel.fromJson(Map<String, dynamic> json) => AddMaterialsModel(
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
    int companyId;
    int siteId;
    int quantity;
    int unitId;
    int price;
    int totalAmount;
    String supplier;
    DateTime addedDate;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Data({
        required this.name,
        required this.companyId,
        required this.siteId,
        required this.quantity,
        required this.unitId,
        required this.price,
        required this.totalAmount,
        required this.supplier,
        required this.addedDate,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        companyId: json["company_id"],
        siteId: json["site_id"],
        quantity: json["quantity"],
        unitId: json["unit_id"],
        price: json["price"],
        totalAmount: json["total_amount"],
        supplier: json["supplier"],
        addedDate: DateTime.parse(json["added_date"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "company_id": companyId,
        "site_id": siteId,
        "quantity": quantity,
        "unit_id": unitId,
        "price": price,
        "total_amount": totalAmount,
        "supplier": supplier,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
