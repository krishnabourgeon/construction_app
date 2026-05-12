// To parse this JSON data, do
//
//     final totalReceivedDetailModel = totalReceivedDetailModelFromJson(jsonString);

import 'dart:convert';

TotalReceivedDetailModel totalReceivedDetailModelFromJson(String str) => TotalReceivedDetailModel.fromJson(json.decode(str));

String totalReceivedDetailModelToJson(TotalReceivedDetailModel data) => json.encode(data.toJson());

class TotalReceivedDetailModel {
    bool status;
    String message;
    TotalReceived data;

    TotalReceivedDetailModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TotalReceivedDetailModel.fromJson(Map<String, dynamic> json) => TotalReceivedDetailModel(
        status: json["status"],
        message: json["message"],
        data: TotalReceived.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class TotalReceived {
    String siteName;
    int totalReceived;
    List<Payment> payments;

    TotalReceived({
        required this.siteName,
        required this.totalReceived,
        required this.payments,
    });

    factory TotalReceived.fromJson(Map<String, dynamic> json) => TotalReceived(
        siteName: json["site_name"],
        totalReceived: json["total_received"],
        payments: List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site_name": siteName,
        "total_received": totalReceived,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
    };
}

class Payment {
    int id;
    DateTime paymentDate;
    String amount;
    String? paymentMode;
    String? stageName;
    String? remarks;

    Payment({
        required this.id,
        required this.paymentDate,
        required this.amount,
        this.paymentMode,
        this.stageName,
        this.remarks,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        paymentDate: DateTime.parse(json["payment_date"]),
        amount: json["amount"],
        paymentMode: json["payment_mode"],
        stageName: json["stage_name"],
        remarks: json["remarks"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "payment_date": "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "payment_mode": paymentMode,
        "stage_name": stageName,
        "remarks": remarks,
    };
}
