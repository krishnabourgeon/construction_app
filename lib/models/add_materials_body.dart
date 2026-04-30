// To parse this JSON data, do
//
//     final addMaterialsBody = addMaterialsBodyFromJson(jsonString);

import 'dart:convert';

AddMaterialsBody addMaterialsBodyFromJson(String str) => AddMaterialsBody.fromJson(json.decode(str));

String addMaterialsBodyToJson(AddMaterialsBody data) => json.encode(data.toJson());

class AddMaterialsBody {
    int siteId;
    int categoryId;
    String name;
    int qty;
    int unitId;
    int price;
    int totalAmount;
    int supplierId;
    int substageId;
    DateTime addedDate;

    AddMaterialsBody({
        required this.siteId,
        required this.categoryId,
        required this.name,
        required this.qty,
        required this.unitId,
        required this.price,
        required this.totalAmount,
        required this.supplierId,
        required this.substageId,
        required this.addedDate,
    });

    factory AddMaterialsBody.fromJson(Map<String, dynamic> json) => AddMaterialsBody(
        siteId: json["site_id"],
        categoryId: json["category_id"],
        name: json["name"],
        qty: json["qty"],
        unitId: json["unit_id"],
        price: json["price"],
        totalAmount: json["total_amount"],
        supplierId: json["supplier_id"],
        substageId: json["substage_id"],
        addedDate: DateTime.parse(json["added_date"]),
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "category_id": categoryId,
        "name": name,
        "qty": qty,
        "unit_id": unitId,
        "price": price,
        "total_amount": totalAmount,
        "supplier_id": supplierId,
        "substage_id": substageId,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
    };
}
