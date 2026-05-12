// To parse this JSON data, do
//
//     final paymentBody = paymentBodyFromJson(jsonString);

import 'dart:convert';

PaymentBody paymentBodyFromJson(String str) => PaymentBody.fromJson(json.decode(str));

String paymentBodyToJson(PaymentBody data) => json.encode(data.toJson());

class PaymentBody {
    int siteId;
    int stageId;
    DateTime paymentDate;
    int amount;
    int paymentModeId;
    String remarks;
    int paymentType;

    PaymentBody({
        required this.siteId,
        required this.stageId,
        required this.paymentDate,
        required this.amount,
        required this.paymentModeId,
        required this.remarks,
        required this.paymentType,
    });

    factory PaymentBody.fromJson(Map<String, dynamic> json) => PaymentBody(
        siteId: json["site_id"],
        stageId: json["stage_id"],
        paymentDate: DateTime.parse(json["payment_date"]),
        amount: json["amount"],
        paymentModeId: json["payment_mode_id"],
        remarks: json["remarks"],
        paymentType: json["payment_type"],
    );

    Map<String, dynamic> toJson() => {
        "site_id": siteId,
        "stage_id": stageId,
        "payment_date": "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "payment_mode_id": paymentModeId,
        "payment_mode": paymentModeId,
        "remarks": remarks,
        "payment_type": paymentType,
    };
}
