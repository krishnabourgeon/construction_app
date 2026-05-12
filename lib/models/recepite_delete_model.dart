// To parse this JSON data, do
//
//     final receiptDeleteModel = receiptDeleteModelFromJson(jsonString);

import 'dart:convert';

ReceiptDeleteModel receiptDeleteModelFromJson(String str) => ReceiptDeleteModel.fromJson(json.decode(str));

String receiptDeleteModelToJson(ReceiptDeleteModel data) => json.encode(data.toJson());

class ReceiptDeleteModel {
    bool status;
    String message;

    ReceiptDeleteModel({
        required this.status,
        required this.message,
    });

    factory ReceiptDeleteModel.fromJson(Map<String, dynamic> json) => ReceiptDeleteModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
