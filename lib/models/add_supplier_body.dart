// To parse this JSON data, do
//
//     final addSupplierBody = addSupplierBodyFromJson(jsonString);

import 'dart:convert';

AddSupplierBody addSupplierBodyFromJson(String str) => AddSupplierBody.fromJson(json.decode(str));

String addSupplierBodyToJson(AddSupplierBody data) => json.encode(data.toJson());

class AddSupplierBody {
    String name;
    String contactNo;
    String address;

    AddSupplierBody({
        required this.name,
        required this.contactNo,
        required this.address,
    });

    factory AddSupplierBody.fromJson(Map<String, dynamic> json) => AddSupplierBody(
        name: json["name"],
        contactNo: json["contact_no"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "contact_no": contactNo,
        "address": address,
    };
}
