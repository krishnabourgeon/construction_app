// To parse this JSON data, do
//
//     final supplierDetailModel = supplierDetailModelFromJson(jsonString);

import 'dart:convert';

SupplierDetailModel supplierDetailModelFromJson(String str) => SupplierDetailModel.fromJson(json.decode(str));

String supplierDetailModelToJson(SupplierDetailModel data) => json.encode(data.toJson());

class SupplierDetailModel {
    bool status;
    String message;
    SupplierDetailData data;

    SupplierDetailModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SupplierDetailModel.fromJson(Map<String, dynamic> json) => SupplierDetailModel(
        status: json["status"],
        message: json["message"],
        data: SupplierDetailData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class SupplierDetailData {
    int id;
    String name;
    String contactNo;
    String address;
    int totalOrders;
    int totalSpent;
    List<MaterialDetails> materials;

    SupplierDetailData({
        required this.id,
        required this.name,
        required this.contactNo,
        required this.address,
        required this.totalOrders,
        required this.totalSpent,
        required this.materials,
    });

    factory SupplierDetailData.fromJson(Map<String, dynamic> json) => SupplierDetailData(
        id: json["id"],
        name: json["name"],
        contactNo: json["contact_no"],
        address: json["address"],
        totalOrders: json["total_orders"],
        totalSpent: json["total_spent"],
        materials: List<MaterialDetails>.from(json["materials"].map((x) => MaterialDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact_no": contactNo,
        "address": address,
        "total_orders": totalOrders,
        "total_spent": totalSpent,
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
    };
}

class MaterialDetails {
    int siteMaterialId;
    String materialName;
    dynamic siteName;
    DateTime addedDate;
    String amount;
    String qty;
    String unit;
    String price;

    MaterialDetails({
        required this.siteMaterialId,
        required this.materialName,
        required this.siteName,
        required this.addedDate,
        required this.amount,
        required this.qty,
        required this.unit,
        required this.price,
    });

    factory MaterialDetails.fromJson(Map<String, dynamic> json) => MaterialDetails(
        siteMaterialId: json["site_material_id"],
        materialName: json["material_name"],
        siteName: json["site_name"],
        addedDate: DateTime.parse(json["added_date"]),
        amount: json["amount"],
        qty: json["qty"],
        unit: json["unit"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "site_material_id": siteMaterialId,
        "material_name": materialName,
        "site_name": siteName,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "qty": qty,
        "unit": unit,
        "price": price,
    };
}
