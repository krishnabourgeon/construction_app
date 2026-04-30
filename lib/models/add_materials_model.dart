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
    Material material;
    Mapping mapping;

    Data({
        required this.material,
        required this.mapping,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        material: Material.fromJson(json["material"]),
        mapping: Mapping.fromJson(json["mapping"]),
    );

    Map<String, dynamic> toJson() => {
        "material": material.toJson(),
        "mapping": mapping.toJson(),
    };
}

class Mapping {
    int siteId;
    int categoryId;
    int qty;
    int unitId;
    int substageId;
    int price;
    int amount;
    int supplierId;
    DateTime addedDate;
    int materialId;
    int companyId;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Mapping({
        required this.siteId,
        required this.categoryId,
        required this.qty,
        required this.unitId,
        required this.substageId,
        required this.price,
        required this.amount,
        required this.supplierId,
        required this.addedDate,
        required this.materialId,
        required this.companyId,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Mapping.fromJson(Map<String, dynamic> json) => Mapping(
        siteId: json["site_id"],
        categoryId: json["category_id"],
        qty: json["qty"],
        unitId: json["unit_id"],
        substageId: json["substage_id"],
        price: json["price"],
        amount: json["amount"],
        supplierId: json["supplier_id"],
        addedDate: DateTime.parse(json["added_date"]),
        materialId: json["material_id"],
        companyId: json["company_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "category_id": categoryId,
        "qty": qty,
        "unit_id": unitId,
        "substage_id": substageId,
        "price": price,
        "amount": amount,
        "supplier_id": supplierId,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "material_id": materialId,
        "company_id": companyId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}

class Material {
    String name;
    int categoryId;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Material({
        required this.name,
        required this.categoryId,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Material.fromJson(Map<String, dynamic> json) => Material(
        name: json["name"],
        categoryId: json["category_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "category_id": categoryId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
