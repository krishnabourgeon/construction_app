// To parse this JSON data, do
//
//     final materialEditModel = materialEditModelFromJson(jsonString);

import 'dart:convert';

MaterialEditModel materialEditModelFromJson(String str) => MaterialEditModel.fromJson(json.decode(str));

String materialEditModelToJson(MaterialEditModel data) => json.encode(data.toJson());

class MaterialEditModel {
    bool status;
    String message;
    Data data;

    MaterialEditModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory MaterialEditModel.fromJson(Map<String, dynamic> json) => MaterialEditModel(
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
    int id;
    int companyId;
    int siteId;
    int materialId;
    int categoryId;
    int substageId;
    String qty;
    int unitId;
    String price;
    int supplierId;
    String amount;
    DateTime addedDate;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    Mapping({
        required this.id,
        required this.companyId,
        required this.siteId,
        required this.materialId,
        required this.categoryId,
        required this.substageId,
        required this.qty,
        required this.unitId,
        required this.price,
        required this.supplierId,
        required this.amount,
        required this.addedDate,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Mapping.fromJson(Map<String, dynamic> json) => Mapping(
        id: json["id"],
        companyId: json["company_id"],
        siteId: json["site_id"],
        materialId: json["material_id"],
        categoryId: json["category_id"],
        substageId: json["substage_id"],
        qty: json["qty"],
        unitId: json["unit_id"],
        price: json["price"],
        supplierId: json["supplier_id"],
        amount: json["amount"],
        addedDate: DateTime.parse(json["added_date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "site_id": siteId,
        "material_id": materialId,
        "category_id": categoryId,
        "substage_id": substageId,
        "qty": qty,
        "unit_id": unitId,
        "price": price,
        "supplier_id": supplierId,
        "amount": amount,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Material {
    int id;
    String name;
    int companyId;
    int siteId;
    int categoryId;
    int quantity;
    int unitId;
    int price;
    int totalAmount;
    String supplier;
    String addedDate;
    DateTime createdAt;
    DateTime updatedAt;

    Material({
        required this.id,
        required this.name,
        required this.companyId,
        required this.siteId,
        required this.categoryId,
        required this.quantity,
        required this.unitId,
        required this.price,
        required this.totalAmount,
        required this.supplier,
        required this.addedDate,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Material.fromJson(Map<String, dynamic> json) => Material(
        id: json["id"],
        name: json["name"],
        companyId: json["company_id"],
        siteId: json["site_id"],
        categoryId: json["category_id"],
        quantity: json["quantity"],
        unitId: json["unit_id"],
        price: json["price"],
        totalAmount: json["total_amount"],
        supplier: json["supplier"],
        addedDate: json["added_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company_id": companyId,
        "site_id": siteId,
        "category_id": categoryId,
        "quantity": quantity,
        "unit_id": unitId,
        "price": price,
        "total_amount": totalAmount,
        "supplier": supplier,
        "added_date": addedDate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
