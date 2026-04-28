// To parse this JSON data, do
//
//     final addMaterialsBody = addMaterialsBodyFromJson(jsonString);

import 'dart:convert';

AddMaterialsBody addMaterialsBodyFromJson(String str) => AddMaterialsBody.fromJson(json.decode(str));

String addMaterialsBodyToJson(AddMaterialsBody data) => json.encode(data.toJson());

class AddMaterialsBody {
    int companyId;
    int siteId;
    String name;
    int quantity;
    int unitId;
    int price;
    int totalAmount;
    String supplier;
    DateTime addedDate;

    AddMaterialsBody({
        required this.companyId,
        required this.siteId,
        required this.name,
        required this.quantity,
        required this.unitId,
        required this.price,
        required this.totalAmount,
        required this.supplier,
        required this.addedDate,
    });

    factory AddMaterialsBody.fromJson(Map<String, dynamic> json) => AddMaterialsBody(
        companyId: json["company_id"],
        siteId: json["site_id"],
        name: json["name"],
        quantity: json["quantity"],
        unitId: json["unit_id"],
        price: json["price"],
        totalAmount: json["total_amount"],
        supplier: json["supplier"],
        addedDate: DateTime.parse(json["added_date"]),
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "site_id": siteId,
        "name": name,
        "quantity": quantity,
        "unit_id": unitId,
        "price": price,
        "total_amount": totalAmount,
        "supplier": supplier,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
    };
}
