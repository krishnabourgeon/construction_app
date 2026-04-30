// To parse this JSON data, do
//
//     final getMaterialsModel = getMaterialsModelFromJson(jsonString);

import 'dart:convert';

GetMaterialsModel getMaterialsModelFromJson(String str) => GetMaterialsModel.fromJson(json.decode(str));

String getMaterialsModelToJson(GetMaterialsModel data) => json.encode(data.toJson());

class GetMaterialsModel {
    bool status;
    String message;
    List<GetMaterials> data;

    GetMaterialsModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetMaterialsModel.fromJson(Map<String, dynamic> json) => GetMaterialsModel(
        status: json["status"],
        message: json["message"],
        data: List<GetMaterials>.from(json["data"].map((x) => GetMaterials.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetMaterials {
    int id;
    int materialId;
    String materialName;
    String qty;
    int unitId;
    String price;
    String amount;
    int supplierId;
    DateTime addedDate;

    GetMaterials({
        required this.id,
        required this.materialId,
        required this.materialName,
        required this.qty,
        required this.unitId,
        required this.price,
        required this.amount,
        required this.supplierId,
        required this.addedDate,
    });

    factory GetMaterials.fromJson(Map<String, dynamic> json) => GetMaterials(
        id: json["id"],
        materialId: json["material_id"],
        materialName: json["material_name"],
        qty: json["qty"],
        unitId: json["unit_id"],
        price: json["price"],
        amount: json["amount"],
        supplierId: json["supplier_id"],
        addedDate: DateTime.parse(json["added_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "material_id": materialId,
        "material_name": materialName,
        "qty": qty,
        "unit_id": unitId,
        "price": price,
        "amount": amount,
        "supplier_id": supplierId,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
    };
}
